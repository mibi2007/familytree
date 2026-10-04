import { expect, test } from '@playwright/test';

import { enableFlutterSemantics, openFlutterApp } from '../../helpers/flutter';
import { escapeRegex, t } from '../../fixtures/l10n';

const en = (key: string, parameters = {}) => t('en', key, parameters);

test.setTimeout(120_000);

test('signs out of an authenticated user session', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=owner');
  await page.getByRole('button', { name: en('signOut') }).click();
  await expect(page.getByRole('button', { name: en('signIn'), exact: true })).toBeVisible();
});

test('shows localized feedback for an invalid family invite token', async ({ page }) => {
  await openFlutterApp(page, '/?e2eAuth=member');
  await page.getByRole('button', { name: en('joinViaInviteToken') }).click();
  await page.getByLabel(en('inviteToken')).fill('invalid-family-token');
  await page.getByRole('button', { name: en('join'), exact: true }).click();

  const errorPrefix = en('failedToJoin', { error: '' });
  await expect(page.getByText(new RegExp(`^${escapeRegex(errorPrefix)}`))).toBeVisible();
  await expect(page.getByText(en('joinFamily'), { exact: true })).toBeVisible();
});

test('creates a family, adds a member, invites another user, and chats', async ({ browser, page }) => {
  await openFlutterApp(page, '/?e2eAuth=owner');

  await page.getByRole('button', { name: en('createMyFamily') }).click();
  await page.getByLabel(en('familyName')).fill('Playwright Family');
  await page.getByRole('button', { name: en('create'), exact: true }).click();
  const ownerFamilyCard = page.getByRole('button', {
    name: new RegExp(`Playwright Family ${escapeRegex(en('familyId', { id: '' }))}`),
  });
  await expect(ownerFamilyCard).toBeVisible();

  await ownerFamilyCard.click();
  await page.getByRole('button', { name: en('addFirstMember') }).click();
  await page.getByLabel(en('displayName')).fill('Family Root');
  await page.getByRole('button', { name: en('add'), exact: true }).click();
  await page.getByRole('button', { name: en('switchToList') }).click();
  const rootMember = page.getByRole('button', {
    name: new RegExp(`Family Root ${escapeRegex(en('levelValue', { level: 0 }))}`),
  });
  await expect(rootMember).toBeVisible();

  await rootMember.click();
  await page.getByRole('button', { name: en('addChild') }).click();
  await page.getByLabel(en('displayName')).fill('Family Child');
  await page.getByRole('button', { name: en('add'), exact: true }).click();
  const childMember = page.getByRole('button', {
    name: new RegExp(`Family Child ${escapeRegex(en('levelValue', { level: 1 }))}`),
  });
  await expect(childMember).toBeVisible();

  await page.getByRole('button', { name: en('showTitlesAs') }).click();
  await page.getByRole('menuitem', { name: 'Family Root' }).click();
  await childMember.click();
  const kinshipLabel = en('kinshipResult', { title: 'Con', details: 'child' });
  await expect(
    page.locator('flt-semantics').filter({ hasText: new RegExp(`^${escapeRegex(kinshipLabel)}`) }).last(),
  ).toBeVisible();
  await page.keyboard.press('Escape');

  await page.getByRole('button', { name: en('inviteMember') }).click();
  await expect(page.getByText(en('shareInviteToken'))).toBeVisible();
  const invitePrefix = en('inviteTokenValue', { token: '' });
  const tokenLabel = await page.getByText(new RegExp(`^${escapeRegex(invitePrefix)}`)).textContent();
  const inviteToken = tokenLabel?.replace(invitePrefix, '') ?? '';
  expect(inviteToken).toMatch(/^[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}$/);

  const memberContext = await browser.newContext({
    baseURL: 'http://127.0.0.1:8082',
  });
  const memberPage = await memberContext.newPage();
  await openFlutterApp(memberPage, '/?e2eAuth=member');
  await memberPage.getByRole('button', { name: en('joinViaInviteToken') }).click();
  await memberPage.getByLabel(en('inviteToken')).fill(inviteToken);
  await memberPage.getByRole('button', { name: en('join'), exact: true }).click();
  const memberFamilyCard = memberPage.getByRole('button', {
    name: new RegExp(`Playwright Family ${escapeRegex(en('familyId', { id: '' }))}`),
  });
  await expect(memberFamilyCard).toBeVisible();

  const secondMemberContext = await browser.newContext({
    baseURL: 'http://127.0.0.1:8082',
  });
  const secondMemberPage = await secondMemberContext.newPage();
  await openFlutterApp(secondMemberPage, '/?e2eAuth=secondMember');
  await secondMemberPage.getByRole('button', { name: en('joinViaInviteToken') }).click();
  await secondMemberPage.getByLabel(en('inviteToken')).fill(inviteToken);
  await secondMemberPage.getByRole('button', { name: en('join'), exact: true }).click();
  const usedTokenError = en('failedToJoin', { error: '' });
  await expect(secondMemberPage.getByText(new RegExp(`^${escapeRegex(usedTokenError)}`))).toBeVisible();
  await expect(secondMemberPage.getByText(en('joinFamily'), { exact: true })).toBeVisible();

  await page.getByRole('button', { name: en('close') }).click();
  await page.getByRole('button', { name: en('familyChat') }).click();
  await memberFamilyCard.click();
  await memberPage.getByRole('button', { name: en('familyChat') }).click();

  const messageInput = page.getByRole('textbox', { name: en('typeMessage') });
  await messageInput.click();
  await messageInput.press('Space');
  await messageInput.press('Backspace');
  await messageInput.pressSequentially('Hello from Playwright', { delay: 20 });
  await messageInput.press('Enter');
  const expectedMessage = en('chatMessage', { content: 'Hello from Playwright' });
  await expect(page.getByText(new RegExp(`^${escapeRegex(expectedMessage)}`))).toBeVisible();
  await expect(memberPage.getByText(new RegExp(`^${escapeRegex(expectedMessage)}`))).toBeVisible();

  await secondMemberContext.close();
  await memberContext.close();
});
