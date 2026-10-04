import { expect, test, type Locator } from '@playwright/test';

import { openFlutterApp } from '../../helpers/flutter';
import { escapeRegex, t } from '../../fixtures/l10n';

const en = (key: string, parameters = {}) => t('en', key, parameters);
const vi = (key: string, parameters = {}) => t('vi', key, parameters);

function localizedName(key: string): RegExp {
  return new RegExp(`^(?:${escapeRegex(en(key))}|${escapeRegex(vi(key))})$`);
}

async function typeIntoFlutterField(field: Locator, value: string): Promise<void> {
  for (let attempt = 0; attempt < 3; attempt += 1) {
    await field.click();
    await field.press('ControlOrMeta+A');
    await field.press('Backspace');
    await field.press('Space');
    await field.press('Backspace');
    await field.pressSequentially(value);
    if (await field.inputValue() === value) return;
  }
  throw new Error(`Flutter text field did not accept the expected value: ${value}`);
}

test('loads the user login screen against local services', async ({ page }) => {
  await openFlutterApp(page);
  await expect(page.getByLabel(en('email'))).toBeVisible();
  await expect(page.getByLabel(en('password'))).toBeVisible();
  await expect(page.getByRole('button', { name: en('signIn'), exact: true })).toBeVisible();
});

test('shows an error for invalid credentials', async ({ page }) => {
  await openFlutterApp(page);
  const email = page.getByLabel(en('email'));
  await typeIntoFlutterField(email, 'owner@familytree.e2e');

  const password = page.getByLabel(en('password'));
  await typeIntoFlutterField(password, 'incorrect-password');
  await page.getByRole('button', { name: en('signIn'), exact: true }).click();

  const errorPrefix = en('authenticationError', { error: '' });
  await expect(page.getByText(new RegExp(`^${escapeRegex(errorPrefix)}`)).last()).toBeVisible();
  await expect(page.getByRole('button', { name: en('signIn'), exact: true })).toBeVisible();
});

test('signs up and signs back in with an email account', async ({ page }) => {
  const emailAddress = 'new-user@familytree.e2e';
  const passwordValue = 'NewUserPass123!';

  await openFlutterApp(page);
  await typeIntoFlutterField(page.getByLabel(en('email')), emailAddress);
  await typeIntoFlutterField(page.getByLabel(en('password')), passwordValue);
  await page.getByRole('button', { name: en('signUpPrompt') }).click();
  await expect(page.getByRole('button', { name: localizedName('createMyFamily') })).toBeVisible();

  await page.getByRole('button', { name: localizedName('signOut') }).click();
  await expect(page.getByRole('button', { name: localizedName('signIn') })).toBeVisible();

  await typeIntoFlutterField(page.getByLabel(localizedName('email')), emailAddress);
  await typeIntoFlutterField(page.getByLabel(localizedName('password')), passwordValue);
  await page.getByRole('button', { name: localizedName('signIn') }).click();
  await expect(page.getByRole('button', { name: localizedName('createMyFamily') })).toBeVisible();
});
