# Settings - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `UserSettings` (ThemeMode, Locale).
- **Interfaces**: `ISettingsRepository`.

### 2. Data Layer
- **Implementation**: `SettingsRepositoryImpl`.
- **Data Sources**:
  - `LocalSettingsDataSource` (SharedPreferences).
  - `RemoteSettingsDataSource` (PostgreSQL API).

### 3. App Layer
- **Providers**: 
  - `settingsNotifierProvider`: Notifies UI of changes and syncs to disk.
- **Use Cases**: `UpdateThemeUseCase`, `UpdateLanguageUseCase`.

### 4. View Layer
- **Widgets**: `ThemeToggle`, `LanguagePicker`.
- **Pages**: `SettingsPage`.
