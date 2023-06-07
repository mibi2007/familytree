import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/settings_controller.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsNotifierProvider.notifier);
    final state = ref.watch(settingsNotifierProvider);
    return Switch(
      value: state.themeMode == ThemeMode.light,
      onChanged: (bool value) {
        controller.updateThemeMode(
          value ? ThemeMode.light : ThemeMode.dark,
        );
      },
    );
  }
}
