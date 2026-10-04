import { expect, test } from '@playwright/test';

import { openFlutterApp } from '../../helpers/flutter';

test.setTimeout(90_000);

test('shows local backend and database health', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=admin');
  await expect(page.getByText('System Health', { exact: true })).toBeVisible();
  await expect(page.getByRole('checkbox', { name: 'DEGRADED' })).toBeVisible();
  await expect(page.getByRole('group', { name: /Backend Status.*PostgreSQL Connected/ })).toBeVisible();
});

test('generates an expiring super-admin invitation token', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=admin#/requests');
  await page.getByRole('button', { name: 'Invite Admin' }).click();
  await expect(page.getByText('Generate Invite Token')).toBeVisible();
  await expect(page.getByRole('checkbox', { name: 'Role: SUPER_ADMIN' })).toBeVisible();
  await page.getByRole('button', { name: 'Generate', exact: true }).click();
  await expect(page.getByText('Token Generated:')).toBeVisible();

  const tokenNode = page.locator('flt-semantics').filter({ hasText: /^Admin invite token: / }).last();
  const tokenLabel = await tokenNode.textContent();
  const token = tokenLabel?.replace('Admin invite token: ', '') ?? '';
  expect(token).toMatch(/^[0-9a-f]{32}$/);
  await expect(page.getByText(/Expires: /)).toBeVisible();
  await expect(page.getByRole('button', { name: 'Copy admin invite token' })).toBeVisible();
  await page.getByRole('button', { name: 'Done' }).click();
});

test('approves a seeded admin request', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=admin#/requests');
  const request = page.getByRole('group', { name: /E2E Pending Admin.*Playwright approval request/ });
  await expect(request).toBeVisible();
  await request.getByRole('button', { name: 'Approve' }).click();
  await expect(page.getByText('Request approved!')).toBeVisible();
});

test('rejects a seeded admin request', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=admin#/requests');
  const request = page.getByRole('group', { name: /E2E Rejected Admin.*Playwright rejection request/ });
  await expect(request).toBeVisible();
  await request.getByRole('button', { name: 'Reject' }).click();
  await expect(page.getByText('Request rejected')).toBeVisible();
});

test('revokes another super admin', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=admin#/requests');
  await page.getByRole('tab', { name: 'Manage Admins' }).click();
  const revoke = page.getByRole('button', { name: 'Revoke revocable-admin@familytree.e2e' });
  await expect(revoke).toBeVisible();
  await revoke.click();
  await expect(page.getByText('Are you sure you want to remove revocable-admin@familytree.e2e from Super Admins?')).toBeVisible();
  await page.getByRole('button', { name: 'Revoke', exact: true }).click();
  await expect(revoke).toBeHidden();
});

test('submits a new onboarding request visible to the root admin', async ({ browser, page }) => {
  await openFlutterApp(page, '/?e2eAuth=applicant');
  const tokenInput = page.getByLabel('Invite Token');
  await tokenInput.click();
  await tokenInput.press('Space');
  await tokenInput.press('Backspace');
  await tokenInput.pressSequentially('11111111111111111111111111111111');
  const reasonInput = page.getByLabel('Reason for Access');
  await reasonInput.click();
  await reasonInput.press('Space');
  await reasonInput.press('Backspace');
  await reasonInput.pressSequentially('Playwright submitted onboarding request');
  await page.getByRole('button', { name: 'Submit Request' }).click();
  await expect(page.getByText('Request Submitted')).toBeVisible();
  await page.getByRole('button', { name: 'OK' }).click();
  await expect(page.getByText('Access Pending')).toBeVisible();

  const rootContext = await browser.newContext({ baseURL: 'http://127.0.0.1:8081' });
  const rootPage = await rootContext.newPage();
  await openFlutterApp(rootPage, '/?e2eAuth=admin#/requests');
  await expect(
    rootPage.getByRole('group', {
      name: /E2E Onboarding Applicant.*Playwright submitted onboarding request/,
    }),
  ).toBeVisible();
  await rootContext.close();
});
