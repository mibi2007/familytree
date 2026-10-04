import { expect, test } from '@playwright/test';

import { openFlutterApp } from '../../helpers/flutter';

test('redirects an unauthenticated visitor to admin login', async ({ page }) => {
  await openFlutterApp(page);
  await expect(page.getByText('Admin Console')).toBeVisible();
  await expect(page.getByRole('button', { name: 'Sign in with Google' })).toBeVisible();
});

test('routes a pending admin to access review', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=pending');
  await expect(page.getByText('Access Pending')).toBeVisible();
  await expect(page.getByText('Your request is currently under review.')).toBeVisible();
  await expect(page.getByRole('button', { name: 'Sign Out' })).toBeVisible();
});

test('routes a rejected admin back to the request form', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=rejected');
  await expect(page.getByText('Request Admin Access')).toBeVisible();
  await expect(
    page.getByRole('group', { name: /Your previous request was rejected. You may submit a new one./ }),
  ).toBeVisible();
  await expect(page.getByRole('button', { name: 'Submit Request' })).toBeVisible();
});
