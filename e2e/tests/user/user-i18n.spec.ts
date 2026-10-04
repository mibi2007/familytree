import { expect, test } from '@playwright/test';

import { openFlutterApp } from '../../helpers/flutter';
import { t, userMessages } from '../../fixtures/l10n';

test('English and Vietnamese ARBs contain the same message keys', () => {
  expect(Object.keys(userMessages.vi).sort()).toEqual(Object.keys(userMessages.en).sort());
});

for (const locale of ['en', 'vi'] as const) {
  test(`renders the login screen from ${locale} localization keys`, async ({ browser }) => {
    const context = await browser.newContext({
      baseURL: 'http://127.0.0.1:8082',
      locale: locale === 'en' ? 'en-US' : 'vi-VN',
    });
    const page = await context.newPage();
    await openFlutterApp(page);

    await expect(page.getByRole('heading', { name: t(locale, 'appTitle') })).toBeVisible();
    await expect(page.getByLabel(t(locale, 'email'))).toBeVisible();
    await expect(page.getByLabel(t(locale, 'password'))).toBeVisible();
    await expect(page.getByRole('button', { name: t(locale, 'signIn'), exact: true })).toBeVisible();
    await context.close();
  });
}

test('switches Vietnamese and English through localized settings keys', async ({ page }) => {
  await openFlutterApp(page);
  await page.getByRole('button', { name: t('en', 'settings') }).click();
  await expect(page.getByRole('heading', { name: t('en', 'settings') })).toBeVisible();

  await page.getByRole('radio', { name: t('en', 'vietnamese') }).click();
  await expect(page.getByRole('heading', { name: t('vi', 'settings') })).toBeVisible();
  await expect(page.getByText(t('vi', 'language'), { exact: true })).toBeVisible();

  await openFlutterApp(page);
  await expect(page.getByRole('heading', { name: t('vi', 'appTitle') })).toBeVisible();
  await page.getByRole('button', { name: t('vi', 'settings') }).click();

  await page.getByRole('radio', { name: t('vi', 'english') }).click();
  await expect(page.getByRole('heading', { name: t('en', 'settings') })).toBeVisible();
});
