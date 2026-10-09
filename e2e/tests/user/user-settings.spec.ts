import { expect, test, type Page } from '@playwright/test';

import { t } from '../../fixtures/l10n';
import { openFlutterApp } from '../../helpers/flutter';

async function openSettings(page: Page): Promise<void> {
  await page.getByRole('button', { name: 'Open navigation menu' }).click();
  await page.getByText(t('en', 'settings'), { exact: true }).click();
}

test('persists theme and notification settings locally', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=owner');
  await openSettings(page);

  const darkMode = page.getByRole('radio', { name: t('en', 'darkMode') });
  const emailNotifications = page.getByRole('switch', { name: t('en', 'emailNotifications') });
  const pushNotifications = page.getByRole('switch', { name: t('en', 'pushNotifications') });

  await darkMode.click();
  await expect(darkMode).toBeChecked();
  await page.mouse.wheel(0, 600);
  await emailNotifications.click();
  await pushNotifications.click();
  await expect(emailNotifications).not.toBeChecked();
  await expect(pushNotifications).not.toBeChecked();

  await expect.poll(() => page.evaluate(() => localStorage.getItem('flutter.theme_mode'))).toContain('dark');
  await expect.poll(() => page.evaluate(() => localStorage.getItem('flutter.email_notifications'))).toContain('false');
  await expect.poll(() => page.evaluate(() => localStorage.getItem('flutter.push_notifications'))).toContain('false');
});
