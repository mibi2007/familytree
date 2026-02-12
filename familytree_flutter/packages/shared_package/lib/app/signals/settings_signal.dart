import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

import '../../data/grpc/generated/proto/settings/v1/settings.pbgrpc.dart';
import '../../data/signals/grpc_client_signals.dart';
import 'auth_signals.dart';

// Local storage keys
// Note: Theme mode is managed by theme_signal.dart
// We only handle language and notification preferences here
const String _kThemeModeKey = 'theme_mode';
const String _kLanguageKey = 'locale';
const String _kEmailNotificationsKey = 'email_notifications';
const String _kPushNotificationsKey = 'push_notifications';

/// Settings signal - holds current user settings
final settingsSignal = signal<AsyncState<UserSettings>>(AsyncState.loading());

/// Computed language signal
final languageSignal = computed(() {
  return settingsSignal.value.map(
    data: (settings) => settings.language,
    loading: () => Language.LANGUAGE_UNSPECIFIED,
    error: (_, __) => Language.LANGUAGE_UNSPECIFIED,
  );
});

/// Initialize settings from local storage on app startup
Future<void> initSettings() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Load from local storage
    final themeModeStr = prefs.getString(_kThemeModeKey) ?? 'system';
    final languageStr = prefs.getString(_kLanguageKey) ?? 'system';
    final emailNotif = prefs.getBool(_kEmailNotificationsKey) ?? true;
    final pushNotif = prefs.getBool(_kPushNotificationsKey) ?? true;

    final settings = UserSettings(
      themeMode: _parseThemeMode(themeModeStr),
      language: _parseLanguage(languageStr),
      emailNotificationsEnabled: emailNotif,
      pushNotificationsEnabled: pushNotif,
    );

    settingsSignal.value = AsyncState.data(settings);
  } catch (e, stack) {
    settingsSignal.value = AsyncState.error(e, stack);
  }
}

/// Sync settings from backend (called after login)
/// Database settings take precedence over local settings
Future<void> syncSettingsFromBackend(String userId) async {
  try {
    final client = settingsClientSignal.value;
    final response = await client.getUserSettings(
      GetUserSettingsRequest(userId: userId),
    ); // Update signal with backend data
    settingsSignal.value = AsyncState.data(response.settings);

    // Persist to local storage
    await _saveToLocal(response.settings);
  } catch (e) {
    // On error, keep local settings
    debugPrint('Failed to sync settings from backend: $e');
    // Don't overwrite local settings on error
  }
}

/// Update settings (saves to both local and backend if authenticated)
Future<void> updateSettings(UserSettings updates) async {
  try {
    final currentUser = authUserSignal.value.map(data: (u) => u, loading: () => null, error: (_, __) => null);

    // Update signal immediately for instant UI feedback
    settingsSignal.value = AsyncState.data(updates);

    // Save to local storage
    await _saveToLocal(updates);

    // Sync to backend if authenticated
    if (currentUser != null) {
      try {
        final client = settingsClientSignal.value;
        final updatedSettings = updates..userId = currentUser.uid;

        await client.updateUserSettings(UpdateUserSettingsRequest(settings: updatedSettings));
      } catch (e) {
        debugPrint('Failed to sync settings to backend: $e');
        // Local settings are already saved, so continue
      }
    }
  } catch (e, stack) {
    settingsSignal.value = AsyncState.error(e, stack);
  }
}

/// Update theme mode only
Future<void> updateThemeMode(ThemeMode mode) async {
  final current = settingsSignal.value.map(
    data: (s) => s,
    loading: () => _defaultSettings(),
    error: (_, __) => _defaultSettings(),
  );

  await updateSettings(current..themeMode = mode);
}

/// Update language only
Future<void> updateLanguage(Language language) async {
  final current = settingsSignal.value.map(
    data: (s) => s,
    loading: () => _defaultSettings(),
    error: (_, __) => _defaultSettings(),
  );

  await updateSettings(current..language = language);
}

/// Update notification settings
Future<void> updateNotifications({bool? email, bool? push}) async {
  final current = settingsSignal.value.map(
    data: (s) => s,
    loading: () => _defaultSettings(),
    error: (_, __) => _defaultSettings(),
  );

  if (email != null) {
    current.emailNotificationsEnabled = email;
  }
  if (push != null) {
    current.pushNotificationsEnabled = push;
  }

  await updateSettings(current);
}

// Helper: Save to local storage
Future<void> _saveToLocal(UserSettings settings) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kThemeModeKey, _themeModeToString(settings.themeMode));
  await prefs.setString(_kLanguageKey, _languageToString(settings.language));
  await prefs.setBool(_kEmailNotificationsKey, settings.emailNotificationsEnabled);
  await prefs.setBool(_kPushNotificationsKey, settings.pushNotificationsEnabled);
}

// Helper: Parse theme mode from string
ThemeMode _parseThemeMode(String value) {
  switch (value.toLowerCase()) {
    case 'light':
      return ThemeMode.THEME_MODE_LIGHT;
    case 'dark':
      return ThemeMode.THEME_MODE_DARK;
    case 'system':
    default:
      return ThemeMode.THEME_MODE_SYSTEM;
  }
}

// Helper: Parse language from string
Language _parseLanguage(String value) {
  switch (value.toLowerCase()) {
    case 'en':
      return Language.LANGUAGE_EN;
    case 'vi':
      return Language.LANGUAGE_VI;
    case 'system':
    default:
      return Language.LANGUAGE_UNSPECIFIED;
  }
}

// Helper: Convert theme mode to string
String _themeModeToString(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.THEME_MODE_LIGHT:
      return 'light';
    case ThemeMode.THEME_MODE_DARK:
      return 'dark';
    case ThemeMode.THEME_MODE_SYSTEM:
    default:
      return 'system';
  }
}

// Helper: Convert language to string
String _languageToString(Language language) {
  switch (language) {
    case Language.LANGUAGE_EN:
      return 'en';
    case Language.LANGUAGE_VI:
      return 'vi';
    case Language.LANGUAGE_UNSPECIFIED:
    default:
      return 'system';
  }
}

// Helper: Default settings
UserSettings _defaultSettings() {
  return UserSettings(
    themeMode: ThemeMode.THEME_MODE_SYSTEM,
    language: Language.LANGUAGE_UNSPECIFIED,
    emailNotificationsEnabled: true,
    pushNotificationsEnabled: true,
  );
}
