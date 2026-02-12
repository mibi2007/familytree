import 'package:flutter/material.dart';
import 'package:signals/signals.dart';
import 'package:shared_package/data/grpc/generated/proto/settings/v1/settings.pb.dart' as proto;

import 'settings_signal.dart';

/// Theme mode options
enum AppThemeMode { light, dark, system }

/// Current theme mode signal (computed from settingsSignal)
///
/// Controls the app's theme mode. Automatically updates when settings change.
final themeModeSignal = computed<AppThemeMode>(() {
  return settingsSignal.value.map(
    data: (settings) {
      switch (settings.themeMode) {
        case proto.ThemeMode.THEME_MODE_LIGHT:
          return AppThemeMode.light;
        case proto.ThemeMode.THEME_MODE_DARK:
          return AppThemeMode.dark;
        case proto.ThemeMode.THEME_MODE_SYSTEM:
        default:
          return AppThemeMode.system;
      }
    },
    loading: () => AppThemeMode.system,
    error: (_, __) => AppThemeMode.system,
  );
});

/// Convert AppThemeMode to Flutter's ThemeMode
ThemeMode toFlutterThemeMode(AppThemeMode mode) {
  switch (mode) {
    case AppThemeMode.light:
      return ThemeMode.light;
    case AppThemeMode.dark:
      return ThemeMode.dark;
    case AppThemeMode.system:
      return ThemeMode.system;
  }
}
