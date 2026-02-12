import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/settings/v1/settings.pb.dart' as proto;
import 'package:shared_package/shared_package.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Admin Settings'), backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'Appearance'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Watch((context) {
              return settingsSignal.value.map(
                data: (settings) {
                  return Column(
                    children: [
                      _ThemeTile(
                        label: 'Light Mode',
                        icon: Icons.light_mode,
                        isSelected: settings.themeMode == proto.ThemeMode.THEME_MODE_LIGHT,
                        onTap: () => _updateTheme(proto.ThemeMode.THEME_MODE_LIGHT, settings),
                      ),
                      const Divider(height: 1),
                      _ThemeTile(
                        label: 'Dark Mode',
                        icon: Icons.dark_mode,
                        isSelected: settings.themeMode == proto.ThemeMode.THEME_MODE_DARK,
                        onTap: () => _updateTheme(proto.ThemeMode.THEME_MODE_DARK, settings),
                      ),
                      const Divider(height: 1),
                      _ThemeTile(
                        label: 'System Default',
                        icon: Icons.brightness_auto,
                        isSelected: settings.themeMode == proto.ThemeMode.THEME_MODE_SYSTEM,
                        onTap: () => _updateTheme(proto.ThemeMode.THEME_MODE_SYSTEM, settings),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              );
            }),
          ),
          const SizedBox(height: 16),
          _buildSectionHeader(context, 'Account'),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text(
                'Revoke Admin Access',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Remove your super admin privileges. You will lose access to this dashboard.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _confirmRevokeAdmin(context),
            ),
          ),
        ],
      ),
    );
  }

  void _updateTheme(proto.ThemeMode mode, proto.UserSettings currentSettings) {
    // Create new settings object with updated theme
    final updatedSettings = proto.UserSettings(
      userId: currentSettings.userId,
      themeMode: mode,
      language: currentSettings.language,
      emailNotificationsEnabled: currentSettings.emailNotificationsEnabled,
      pushNotificationsEnabled: currentSettings.pushNotificationsEnabled,
    );
    updateSettings(updatedSettings);
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[600]),
      ),
    );
  }

  void _confirmRevokeAdmin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Admin Access?'),
        content: const Text(
          'You are about to remove your own Super Admin privileges.\n\nOnce confirmed, you will be logged out of this dashboard immediately and will need a new invitation to regain access.\n\nAre you sure?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          Watch((context) {
            final isLoading = authSignalsController.isLoadingSignal.value;

            return ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final navigator = Navigator.of(context);
                      await authSignalsController.revokeSelf();

                      if (navigator.mounted) navigator.pop();
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Revoke Privileges'),
            );
          }),
        ],
      ),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeTile({required this.label, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : null),
      title: Text(label),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}
