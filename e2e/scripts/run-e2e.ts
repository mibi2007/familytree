import { mkdir, readdir, readFile, rm } from 'node:fs/promises';
import net from 'node:net';
import path from 'node:path';
import postgres from 'postgres';

import { personas } from '../fixtures/personas';

const e2eDir = path.resolve(import.meta.dirname, '..');
const rootDir = path.resolve(e2eDir, '..');
const logsDir = path.join(e2eDir, 'logs');
const authDir = path.join(e2eDir, '.auth');
const projectId = 'mibi-family-tree-dev';
const databaseName = 'familytree_e2e';
const postgresContainerName = 'familytree-postgres-e2e';
const postgresAdminUrl = process.env.E2E_POSTGRES_ADMIN_URL ??
  'postgres://postgres:postgres@127.0.0.1:5432/postgres?sslmode=disable';
const databaseUrl = process.env.E2E_DATABASE_URL ??
  `postgres://postgres:postgres@127.0.0.1:5432/${databaseName}?sslmode=disable`;

type Child = ReturnType<typeof Bun.spawn>;
const children: Child[] = [];
let ownsPostgresContainer = false;

function requireCommand(command: string): void {
  if (!Bun.which(command)) {
    throw new Error(`Required command not found: ${command}`);
  }
}

async function waitForPort(port: number, timeoutMs = 120_000): Promise<void> {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    const connected = await new Promise<boolean>((resolve) => {
      const socket = net.createConnection({ host: '127.0.0.1', port });
      socket.once('connect', () => {
        socket.destroy();
        resolve(true);
      });
      socket.once('error', () => resolve(false));
      socket.setTimeout(500, () => {
        socket.destroy();
        resolve(false);
      });
    });
    if (connected) return;
    await Bun.sleep(500);
  }
  throw new Error(`Timed out waiting for port ${port}`);
}

async function isPortOpen(port: number): Promise<boolean> {
  try {
    await waitForPort(port, 250);
    return true;
  } catch {
    return false;
  }
}

async function assertPortFree(port: number): Promise<void> {
  if (await isPortOpen(port)) {
    throw new Error(`Port ${port} is already in use. Stop the existing service before running E2E tests.`);
  }
}

async function waitForChildPort(child: Child, port: number, timeoutMs = 120_000): Promise<void> {
  await Promise.race([
    waitForPort(port, timeoutMs),
    child.exited.then((code) => {
      throw new Error(`Process exited with code ${code} before opening port ${port}. Check e2e/logs.`);
    }),
  ]);
}

async function waitForHttp(url: string, timeoutMs = 120_000): Promise<void> {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    try {
      const response = await fetch(url, { cache: 'no-store' });
      if (response.ok) return;
    } catch {
      // The server may have opened its port before the Flutter compiler is ready.
    }
    await Bun.sleep(500);
  }
  throw new Error(`Timed out waiting for ${url}`);
}

async function runCommand(command: string[]): Promise<{ code: number; output: string }> {
  const child = Bun.spawn(command, {
    cwd: rootDir,
    env: process.env,
    stdout: 'pipe',
    stderr: 'pipe',
  });
  const [code, stdout, stderr] = await Promise.all([
    child.exited,
    new Response(child.stdout).text(),
    new Response(child.stderr).text(),
  ]);
  return { code, output: `${stdout}${stderr}`.trim() };
}

async function waitForDocker(timeoutMs = 120_000): Promise<{ code: number; output: string }> {
  const deadline = Date.now() + timeoutMs;
  let result = await runCommand(['docker', 'info']);
  while (result.code !== 0 && Date.now() < deadline) {
    await Bun.sleep(2_000);
    result = await runCommand(['docker', 'info']);
  }
  return result;
}

async function ensurePostgres(databaseUrlObject: URL): Promise<void> {
  const port = Number(databaseUrlObject.port || '5432');
  if (await isPortOpen(port)) return;

  if (process.env.E2E_AUTO_POSTGRES === '0') {
    throw new Error(`PostgreSQL is not accepting connections on ${databaseUrlObject.host}.`);
  }
  if (!Bun.which('docker')) {
    throw new Error(
      `PostgreSQL is not accepting connections on ${databaseUrlObject.host}, and Docker is not installed. ` +
      'Start PostgreSQL or install Docker Desktop.',
    );
  }

  let dockerInfo = await runCommand(['docker', 'info']);
  if (dockerInfo.code !== 0 && process.platform === 'darwin') {
    const restart = await runCommand(['docker', 'desktop', 'restart']);
    if (restart.code === 0) {
      dockerInfo = await waitForDocker();
    }
  }
  if (dockerInfo.code !== 0) {
    throw new Error(
      `PostgreSQL is not accepting connections on ${databaseUrlObject.host}, and Docker is not ready. ` +
      `Start Docker Desktop and retry.\n${dockerInfo.output}`,
    );
  }

  const username = decodeURIComponent(databaseUrlObject.username || 'postgres');
  const password = decodeURIComponent(databaseUrlObject.password || 'postgres');
  const started = await runCommand([
    'docker', 'run', '--rm', '--detach',
    '--name', postgresContainerName,
    '--env', `POSTGRES_USER=${username}`,
    '--env', `POSTGRES_PASSWORD=${password}`,
    '--publish', `${port}:5432`,
    'postgres:17-alpine',
  ]);
  if (started.code !== 0) {
    throw new Error(`Failed to start the E2E PostgreSQL container.\n${started.output}`);
  }
  ownsPostgresContainer = true;

  try {
    await waitForPort(port, 60_000);
  } catch {
    await stopPostgres();
    throw new Error(`The E2E PostgreSQL container did not become ready on port ${port}.`);
  }
}

async function stopPostgres(): Promise<void> {
  if (!ownsPostgresContainer) return;
  ownsPostgresContainer = false;
  await runCommand(['docker', 'stop', '--time', '5', postgresContainerName]);
}

function start(name: string, command: string[], cwd: string, env: Record<string, string> = {}): Child {
  const log = Bun.file(path.join(logsDir, `${name}.log`));
  const child = Bun.spawn(command, {
    cwd,
    env: { ...process.env, ...env },
    detached: true,
    stdout: log,
    stderr: log,
  });
  children.push(child);
  return child;
}

async function createFirebaseUsers(): Promise<Record<keyof typeof personas, string>> {
  const base = `http://127.0.0.1:9099`;
  await fetch(`${base}/emulator/v1/projects/${projectId}/accounts`, { method: 'DELETE' });

  const entries = await Promise.all(
    Object.entries(personas).map(async ([name, persona]) => {
      const response = await fetch(
        `${base}/identitytoolkit.googleapis.com/v1/accounts:signUp?key=e2e-fake-key`,
        {
          method: 'POST',
          headers: { 'content-type': 'application/json' },
          body: JSON.stringify({
            email: persona.email,
            password: persona.password,
            displayName: persona.displayName,
            returnSecureToken: true,
          }),
        },
      );
      if (!response.ok) {
        throw new Error(`Failed to seed Firebase user ${name}: ${await response.text()}`);
      }
      const body = await response.json() as { localId: string };
      return [name, body.localId] as const;
    }),
  );

  return Object.fromEntries(entries) as Record<keyof typeof personas, string>;
}

async function resetDatabase(userIds: Record<keyof typeof personas, string>): Promise<void> {
  const admin = postgres(postgresAdminUrl, { max: 1 });
  await admin.unsafe(
    `SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '${databaseName}' AND pid <> pg_backend_pid()`,
  );
  await admin.unsafe(`DROP DATABASE IF EXISTS "${databaseName}"`);
  await admin.unsafe(`CREATE DATABASE "${databaseName}"`);
  await admin.end();

  const sql = postgres(databaseUrl, { max: 1 });
  const migrationsDir = path.join(rootDir, 'familytree_go', 'migrations');
  const migrations = (await readdir(migrationsDir)).filter((file) => file.endsWith('.sql')).sort();
  for (const migration of migrations) {
    await sql.unsafe(await readFile(path.join(migrationsDir, migration), 'utf8'));
  }

  for (const [name, persona] of Object.entries(personas) as [keyof typeof personas, typeof personas[keyof typeof personas]][]) {
    await sql`
      INSERT INTO users (id, email, display_name, photo_url, email_verified, role)
      VALUES (${userIds[name]}, ${persona.email}, ${persona.displayName}, '', true, ${persona.role})
    `;
  }
  for (const name of ['owner', 'member', 'secondMember'] as const) {
    await sql`
      INSERT INTO user_settings (user_id, language)
      VALUES (${userIds[name]}, 'en')
    `;
  }
  await sql`
    INSERT INTO admin_access_requests (id, user_id, requested_role, status, reason)
    VALUES
      (
        '00000000-0000-0000-0000-000000000001',
        ${userIds.pendingAdmin},
        'SUPER_ADMIN',
        'PENDING',
        'Playwright approval request'
      ),
      (
        '00000000-0000-0000-0000-000000000002',
        ${userIds.rejectedAdmin},
        'SUPER_ADMIN',
        'PENDING',
        'Playwright rejection request'
      ),
      (
        '00000000-0000-0000-0000-000000000003',
        ${userIds.onboardingPending},
        'SUPER_ADMIN',
        'PENDING',
        'Playwright onboarding pending request'
      ),
      (
        '00000000-0000-0000-0000-000000000004',
        ${userIds.onboardingRejected},
        'SUPER_ADMIN',
        'REJECTED',
        'Playwright onboarding rejected request'
      )
  `;
  await sql`
    INSERT INTO secure_tokens (token, purpose, created_by, expires_at, is_used)
    VALUES (
      '11111111111111111111111111111111',
      'SUPER_ADMIN_ONBOARDING',
      ${userIds.admin},
      NOW() + INTERVAL '1 hour',
      false
    )
  `;
  await sql.end();
}

async function stopChildren(): Promise<void> {
  const running = children.splice(0).reverse();
  for (const child of running) {
    try {
      process.kill(-child.pid, 'SIGTERM');
    } catch {
      child.kill('SIGTERM');
    }
  }
  const exited = Promise.allSettled(running.map((child) => child.exited));
  const graceful = await Promise.race([exited.then(() => true), Bun.sleep(5_000).then(() => false)]);
  if (!graceful) {
    for (const child of running) {
      try {
        process.kill(-child.pid, 'SIGKILL');
      } catch {
        child.kill('SIGKILL');
      }
    }
    await Promise.allSettled(running.map((child) => child.exited));
  }
}

function selectedFrontends(args: string[]): { user: boolean; admin: boolean } {
  const projects: string[] = [];
  for (let index = 0; index < args.length; index += 1) {
    const argument = args[index];
    if (argument.startsWith('--project=')) {
      projects.push(argument.slice('--project='.length));
    } else if (argument === '--project' && args[index + 1]) {
      projects.push(args[index + 1]);
      index += 1;
    }
  }

  if (projects.length === 0) return { user: true, admin: true };
  const user = projects.some((project) => project.startsWith('user-'));
  const admin = projects.some((project) => project.startsWith('admin-'));
  return user || admin ? { user, admin } : { user: true, admin: true };
}

async function main(): Promise<number> {
  const playwrightArgs = process.argv.slice(2);
  const frontends = selectedFrontends(playwrightArgs);
  for (const command of ['firebase', 'go', 'flutter']) requireCommand(command);
  const databaseUrlObject = new URL(databaseUrl);
  const adminUrlObject = new URL(postgresAdminUrl);
  const loopbackHosts = new Set(['127.0.0.1', 'localhost', '::1', '[::1]']);
  if (!loopbackHosts.has(databaseUrlObject.hostname) || !loopbackHosts.has(adminUrlObject.hostname)) {
    throw new Error('E2E PostgreSQL URLs must target the local machine.');
  }
  if (databaseUrlObject.host !== adminUrlObject.host) {
    throw new Error('E2E database and admin URLs must target the same PostgreSQL server.');
  }
  const urlDatabaseName = databaseUrlObject.pathname.replace(/^\//, '');
  if (urlDatabaseName !== databaseName) {
    throw new Error(`E2E_DATABASE_URL must target exactly ${databaseName}, not ${urlDatabaseName}.`);
  }
  await ensurePostgres(databaseUrlObject);

  await rm(logsDir, { recursive: true, force: true });
  await rm(authDir, { recursive: true, force: true });
  await mkdir(logsDir, { recursive: true });
  await mkdir(authDir, { recursive: true });

  const ownedPorts = [9099, 9000, 9199, 50051, 9090];
  if (frontends.admin) ownedPorts.push(8081);
  if (frontends.user) ownedPorts.push(8082);
  await Promise.all(ownedPorts.map(assertPortFree));

  const firebase = start(
    'firebase',
    ['firebase', 'emulators:start', '--only', 'auth,database,storage', '--project', projectId],
    path.join(rootDir, 'familytree_firebase'),
  );
  await waitForChildPort(firebase, 9099);
  const userIds = await createFirebaseUsers();
  await resetDatabase(userIds);

  const backend = start('backend', ['go', 'run', 'cmd/server/main.go'], path.join(rootDir, 'familytree_go'), {
    APP_ENV: 'e2e',
    DB_CONN: databaseUrl,
    FIREBASE_AUTH_EMULATOR_HOST: '127.0.0.1:9099',
    GOOGLE_CLOUD_PROJECT: projectId,
    GCLOUD_PROJECT: projectId,
    AI_ENABLED: 'false',
  });
  await waitForChildPort(backend, 50051);

  const proxyArgs = [
    '--backend_addr=127.0.0.1:50051',
    '--run_tls_server=false',
    '--allow_all_origins',
    '--server_http_debug_port=9090',
  ];
  const proxyCommand = Bun.which('grpcwebproxy')
    ? ['grpcwebproxy', ...proxyArgs]
    : ['go', 'run', 'github.com/improbable-eng/grpc-web/go/grpcwebproxy@v0.15.0', ...proxyArgs];
  const proxy = start(
    'grpcwebproxy',
    proxyCommand,
    rootDir,
  );
  await waitForChildPort(proxy, 9090);

  const appPorts: Promise<void>[] = [];
  const appAssets: Promise<void>[] = [];
  if (frontends.user) {
    const userApp = start(
      'user-app',
      [
        'flutter', 'run', '-d', 'web-server', '--web-hostname', '127.0.0.1', '--web-port', '8082',
        '-t', 'lib/main_e2e.dart',
        `--dart-define=E2E_OWNER_EMAIL=${personas.owner.email}`,
        `--dart-define=E2E_OWNER_PASSWORD=${personas.owner.password}`,
        `--dart-define=E2E_MEMBER_EMAIL=${personas.member.email}`,
        `--dart-define=E2E_MEMBER_PASSWORD=${personas.member.password}`,
        `--dart-define=E2E_SECOND_MEMBER_EMAIL=${personas.secondMember.email}`,
        `--dart-define=E2E_SECOND_MEMBER_PASSWORD=${personas.secondMember.password}`,
      ],
      path.join(rootDir, 'familytree_flutter', 'apps', 'user_app'),
    );
    appPorts.push(waitForChildPort(userApp, 8082, 180_000));
    appAssets.push(waitForHttp('http://127.0.0.1:8082/main.dart.js', 180_000));
  }
  if (frontends.admin) {
    const adminApp = start(
      'admin-app',
      [
        'flutter', 'run', '-d', 'web-server', '--web-hostname', '127.0.0.1', '--web-port', '8081',
        '-t', 'lib/main_e2e.dart',
        `--dart-define=E2E_ADMIN_EMAIL=${personas.admin.email}`,
        `--dart-define=E2E_ADMIN_PASSWORD=${personas.admin.password}`,
        `--dart-define=E2E_PENDING_ADMIN_EMAIL=${personas.onboardingPending.email}`,
        `--dart-define=E2E_PENDING_ADMIN_PASSWORD=${personas.onboardingPending.password}`,
        `--dart-define=E2E_REJECTED_ADMIN_EMAIL=${personas.onboardingRejected.email}`,
        `--dart-define=E2E_REJECTED_ADMIN_PASSWORD=${personas.onboardingRejected.password}`,
        `--dart-define=E2E_APPLICANT_ADMIN_EMAIL=${personas.onboardingApplicant.email}`,
        `--dart-define=E2E_APPLICANT_ADMIN_PASSWORD=${personas.onboardingApplicant.password}`,
      ],
      path.join(rootDir, 'familytree_flutter', 'apps', 'admin_app'),
    );
    appPorts.push(waitForChildPort(adminApp, 8081, 180_000));
    appAssets.push(waitForHttp('http://127.0.0.1:8081/main.dart.js', 180_000));
  }
  await Promise.all(appPorts);
  await Promise.all(appAssets);

  const playwright = Bun.spawn(['bunx', 'playwright', 'test', ...playwrightArgs], {
    cwd: e2eDir,
    env: process.env,
    detached: true,
    stdin: 'inherit',
    stdout: 'inherit',
    stderr: 'inherit',
  });
  children.push(playwright);
  const code = await playwright.exited;
  const playwrightIndex = children.indexOf(playwright);
  if (playwrightIndex >= 0) children.splice(playwrightIndex, 1);
  return code;
}

let exitCode = 1;
let interrupted = false;
for (const signal of ['SIGINT', 'SIGTERM'] as const) {
  process.once(signal, async () => {
    interrupted = true;
    await stopChildren();
    await stopPostgres();
    process.exit(signal === 'SIGINT' ? 130 : 143);
  });
}
try {
  exitCode = await main();
} catch (error) {
  console.error(error);
} finally {
  if (!interrupted) {
    await stopChildren();
    await stopPostgres();
  }
}
process.exit(exitCode);
