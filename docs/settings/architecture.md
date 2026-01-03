# Settings - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `UserSettings` (ThemeMode, Locale).
- **Interfaces**: `ISettingsRepository`.

### 2. Infrastructure Layer
- **Implementation**: `SettingsRepositoryImpl`.
- **Data Sources**:
  - `LocalSettingsDataSource` (SharedPreferences).
  - `RemoteSettingsDataSource` (PostgreSQL API).

### 3. Application Layer
- **Providers**: 
  - `settingsNotifierProvider`: Notifies UI of changes and syncs to disk.
- **Use Cases**: `UpdateThemeUseCase`, `UpdateLanguageUseCase`.

### 4. Presentation Layer
- **Widgets**: `ThemeToggle`, `LanguagePicker`.
- **Pages**: `SettingsPage`.
