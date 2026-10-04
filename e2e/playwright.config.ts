import { defineConfig, devices } from '@playwright/test';
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  workers: 1,
  retries: 0,
  timeout: 45_000,
  expect: { timeout: 10_000 },
  outputDir: './test-results',
  reporter: [['list'], ['html', { open: 'never', outputFolder: 'playwright-report' }]],
  use: {
    ...devices['Desktop Chrome'],
    browserName: 'chromium',
    trace: {
      mode: 'on',
      screenshots: true,
      snapshots: true,
      sources: true,
    },
    screenshot: {
      mode: 'on',
      fullPage: true,
    },
    video: {
      mode: 'on',
      size: { width: 1280, height: 720 },
    },
  },
  projects: [
    {
      name: 'user-smoke',
      testMatch: /user-smoke\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8082' },
    },
    {
      name: 'user-core',
      testMatch: /user-core\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8082' },
    },
    {
      name: 'user-i18n',
      testMatch: /user-i18n\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8082', locale: 'en-US' },
    },
    {
      name: 'user-settings',
      testMatch: /user-settings\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8082', locale: 'en-US' },
    },
    {
      name: 'admin-smoke',
      testMatch: /admin-smoke\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8081' },
    },
    {
      name: 'admin-core',
      testMatch: /admin-core\.spec\.ts/,
      use: { baseURL: 'http://127.0.0.1:8081' },
    },
  ],
});
