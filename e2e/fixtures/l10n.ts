import { readFileSync } from 'node:fs';
import path from 'node:path';

export type UserLocale = 'en' | 'vi';
type Parameters = Record<string, string | number>;

function load(locale: UserLocale): Record<string, string> {
  const file = path.resolve(
    import.meta.dirname,
    `../../familytree_flutter/apps/user_app/lib/l10n/app_${locale}.arb`,
  );
  const arb = JSON.parse(readFileSync(file, 'utf8')) as Record<string, unknown>;
  return Object.fromEntries(
    Object.entries(arb).filter(([key, value]) => !key.startsWith('@') && typeof value === 'string'),
  ) as Record<string, string>;
}

export const userMessages = {
  en: load('en'),
  vi: load('vi'),
} as const;

export function t(locale: UserLocale, key: string, parameters: Parameters = {}): string {
  const template = userMessages[locale][key];
  if (template === undefined) {
    throw new Error(`Missing ${locale} localization key: ${key}`);
  }
  return template.replace(/\{(\w+)\}/g, (_, name: string) => {
    const value = parameters[name];
    if (value === undefined) throw new Error(`Missing parameter ${name} for localization key ${key}`);
    return String(value);
  });
}

export function escapeRegex(value: string): string {
  return value.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}
