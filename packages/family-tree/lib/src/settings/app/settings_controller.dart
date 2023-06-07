import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/settings_service.dart';

part 'settings_controller.freezed.dart';
part 'settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController(this._settingsService) : super(SettingsState.initial()) {
    loadSettings();
  }

  final SettingsService _settingsService;

  Future<void> loadSettings() async {
    final themeMode = await _settingsService.themeMode();
    final locale = await _settingsService.locale();

    state = state.copyWith(
      themeMode: themeMode,
      locale: locale,
    );
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == state.themeMode) return;

    state = state.copyWith(themeMode: newThemeMode);

    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateLocale(Locale? newLocale) async {
    if (newLocale == null) return;

    if (newLocale == state.locale) return;

    state = state.copyWith(locale: newLocale);

    await _settingsService.updateLocale(newLocale);
  }
}

final settingsNotifierProvider = StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController(ref.read(settingsServiceProvider));
});
