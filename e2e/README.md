# Playwright E2E

This suite exercises both Flutter Web apps through the local Firebase emulators, Go backend, gRPC-Web proxy, and a disposable PostgreSQL database.

## Safety

The runner drops and recreates only `familytree_e2e`. Both PostgreSQL URLs must target the same loopback server; remote databases and alternate database names are rejected.

## Prerequisites

- Bun
- Flutter
- Go
- Firebase CLI and Java
- `grpcwebproxy` (optional; the runner falls back to `go run`)
- PostgreSQL running at `127.0.0.1:5432`, or Docker Desktop
- A PostgreSQL account allowed to create databases and the `unaccent` extension when using an existing server

Defaults assume `postgres:postgres`. Override them when necessary:

```bash
export E2E_POSTGRES_ADMIN_URL='postgres://postgres:password@127.0.0.1:5432/postgres?sslmode=disable'
export E2E_DATABASE_URL='postgres://postgres:password@127.0.0.1:5432/familytree_e2e?sslmode=disable'
```

`E2E_DATABASE_URL` must continue to target the exact database name `familytree_e2e`.

If PostgreSQL is unavailable and Docker is ready, the runner automatically starts and removes a dedicated `familytree-postgres-e2e` container. Set `E2E_AUTO_POSTGRES=0` to require an externally managed PostgreSQL server instead.

## Commands

```bash
task e2e:install
task e2e:test
task e2e:test-ui
task e2e:report
```

Without Task installed:

```bash
cd e2e
bun install
bun run install:browsers
bun run test
```

For focused development, run only the related project:

```bash
bun run test:user-smoke
bun run test:user-core
bun run test:user-i18n
bun run test:user-settings
bun run test:admin-smoke
bun run test:admin-core
```

Use `bun run test:user` or `bun run test:admin` to run every project for one app. Append Playwright filters when needed, for example:

```bash
bun run test:user-core -- --grep "invalid family invite"
```

The runner owns and terminates Firebase, Go, `grpcwebproxy`, and only the Flutter web server(s) required by selected projects. Service logs are written to `e2e/logs/`.

Every test retains full diagnostics, including passing tests:

- `e2e/playwright-report/index.html` - HTML report with artifact links
- `e2e/test-results/**/trace.zip` - timeline, DOM snapshots, network, console, and sources
- `e2e/test-results/**/*.webm` - 1280x720 test video
- `e2e/test-results/**/*.png` - full-page screenshot

Open the report with `bun run report`. Open an individual trace with:

```bash
bunx playwright show-trace test-results/<test-folder>/trace.zip
```

Full capture uses more disk space. Playwright clears the previous `test-results/` when a new run starts.

## Seeded Personas

Credentials live in `fixtures/personas.ts` and are valid only in the freshly reset Firebase emulator. The database contains matching user IDs and roles for an owner, family member, root admin, approval/rejection candidates, and a revocable admin.

Both apps use query-gated authentication hooks in `main_e2e.dart` to establish emulator sessions for core-flow contexts. Production and normal local entrypoints do not include this behavior.

## Coverage

- User signup, login/re-login, invalid-credential feedback, and authenticated logout
- English/Vietnamese ARB key parity and locale rendering
- Persistent runtime language switching between English and Vietnamese
- Theme and notification preference persistence after reload
- Family creation, parent/child members, kinship lookup, invite generation, and invite acceptance
- Invalid and already-used family invite-token feedback and backend safety
- Cross-user live chat
- Admin login routing and local system health
- Pending and rejected admin onboarding routing
- New admin onboarding submission and root-admin visibility
- Admin invitation-token generation, expiry, and copy controls
- Admin request approval and rejection
- Super-admin revocation

User-app selectors are loaded directly from `familytree_flutter/apps/user_app/lib/l10n/app_en.arb` and `app_vi.arb` through `fixtures/l10n.ts`. Functional user flows use seeded English settings; multilingual tests explicitly exercise both locales and verify locale persistence after reload.

## Direct Runs

Use `bun run test:direct` only when the complete E2E stack is already running. Normal development should use `bun run test` so database and emulator state are deterministic.

The database and emulators reset when the managed runner starts. Restart `bun run test:ui` before rerunning mutating tests so they begin from clean fixtures.
