part of 'settings_controller.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required ThemeMode themeMode,
    required Locale locale,
  }) = _SettingsState;
  factory SettingsState.initial() => const SettingsState(
        themeMode: ThemeMode.system,
        locale: Locale('vi'),
      );
}
