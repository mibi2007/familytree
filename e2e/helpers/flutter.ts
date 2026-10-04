import { expect, type Page } from '@playwright/test';

export async function enableFlutterSemantics(page: Page): Promise<void> {
  for (let attempt = 0; attempt < 2; attempt += 1) {
    const accessibilityButton = page.getByRole('button', { name: 'Enable accessibility' });
    const semanticsAvailable = await accessibilityButton
      .waitFor({ state: 'visible', timeout: 15_000 })
      .then(() => true)
      .catch(() => false);
    if (semanticsAvailable) {
      await accessibilityButton.evaluate((element: HTMLElement) => element.click());
      await expect(accessibilityButton).toBeHidden();
      return;
    }
    await page.reload();
  }
  throw new Error('Flutter accessibility semantics did not become available after reloading the app.');
}

export async function openFlutterApp(page: Page, url = '/'): Promise<void> {
  await page.goto(url);
  await enableFlutterSemantics(page);
}
