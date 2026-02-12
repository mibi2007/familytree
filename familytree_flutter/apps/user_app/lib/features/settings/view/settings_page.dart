import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/settings/v1/settings.pb.dart' as proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Watch((_) {
        // Watch the settings signal
        final settingsAsync = settingsSignal.value;

        return settingsAsync.map(
          data: (settings) => _buildSettingsList(context, l10n, settings),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, __) => Center(child: Text('Error: $err')),
        );
      }),
    );
  }

  Widget _buildSettingsList(BuildContext context, AppLocalizations l10n, UserSettings settings) {
    return ListView(
      children: [
        // Language Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            l10n.language,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RadioListTile<proto.Language>(
          title: Text(l10n.systemMode),
          value: proto.Language.LANGUAGE_UNSPECIFIED,
          groupValue: settings.language,
          onChanged: (val) {
            if (val != null) updateLanguage(val);
          },
        ),
        RadioListTile<proto.Language>(
          title: Text(l10n.vietnamese),
          value: proto.Language.LANGUAGE_VI,
          groupValue: settings.language,
          onChanged: (val) {
            if (val != null) updateLanguage(val);
          },
        ),
        RadioListTile<proto.Language>(
          title: Text(l10n.english),
          value: proto.Language.LANGUAGE_EN,
          groupValue: settings.language,
          onChanged: (val) {
            if (val != null) updateLanguage(val);
          },
        ),
        const Divider(),

        // Theme Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            l10n.theme,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RadioListTile<proto.ThemeMode>(
          title: Text(l10n.systemMode),
          value: proto.ThemeMode.THEME_MODE_SYSTEM,
          groupValue: settings.themeMode,
          onChanged: (val) {
            if (val != null) updateThemeMode(val);
          },
        ),
        RadioListTile<proto.ThemeMode>(
          title: Text(l10n.lightMode),
          value: proto.ThemeMode.THEME_MODE_LIGHT,
          groupValue: settings.themeMode,
          onChanged: (val) {
            if (val != null) updateThemeMode(val);
          },
        ),
        RadioListTile<proto.ThemeMode>(
          title: Text(l10n.darkMode),
          value: proto.ThemeMode.THEME_MODE_DARK,
          groupValue: settings.themeMode,
          onChanged: (val) {
            if (val != null) updateThemeMode(val);
          },
        ),

        const Divider(),

        // Notifications Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            l10n.notifications,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SwitchListTile(
          title: Text(l10n.emailNotifications),
          value: settings.emailNotificationsEnabled,
          onChanged: (val) => updateNotifications(email: val),
        ),
        SwitchListTile(
          title: Text(l10n.pushNotifications),
          value: settings.pushNotificationsEnabled,
          onChanged: (val) => updateNotifications(push: val),
        ),
      ],
    );
  }
}
