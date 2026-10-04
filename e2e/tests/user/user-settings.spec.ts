import { expect, test } from '@playwright/test';

import { t } from '../../fixtures/l10n';
import { openFlutterApp } from '../../helpers/flutter';

test('persists theme and notification settings after reload', async ({ page }) => {
  await openFlutterApp(page);
  await page.getByRole('button', { name: t('en', 'settings') }).click();

  const darkMode = page.getByRole('radio', { name: t('en', 'darkMode') });
  const emailNotifications = page.getByRole('switch', { name: t('en', 'emailNotifications') });
  const pushNotifications = page.getByRole('switch', { name: t('en', 'pushNotifications') });

  await darkMode.click();
  await expect(darkMode).toBeChecked();
  await emailNotifications.click();
  await pushNotifications.click();
  await expect(emailNotifications).not.toBeChecked();
  await expect(pushNotifications).not.toBeChecked();

  await openFlutterApp(page);
  await page.getByRole('button', { name: t('en', 'settings') }).click();

  await expect(page.getByRole('radio', { name: t('en', 'darkMode') })).toBeChecked();
  await expect(page.getByRole('switch', { name: t('en', 'emailNotifications') })).not.toBeChecked();
  await expect(page.getByRole('switch', { name: t('en', 'pushNotifications') })).not.toBeChecked();
});
