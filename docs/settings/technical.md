# Settings - Technical Solution

## Local Persistence
- **Storage**: `shared_preferences` for lightweight key-value pairs.
- **Keys**:
  - `theme_mode`: string (light, dark, system).
  - `locale`: string (vi, en).

## State Management & Synchronization
- **Riverpod Providers**:
  - `settingsNotifierProvider`: Orchestrates the sync logic.
- **Sync Logic**:
  1. **Startup**: Load from `shared_preferences`.
  2. **On Auth Change (Logged In)**: 
     - Check if user has settings in PostgreSQL.
     - If yes, overwrite local settings with DB values.
     - If no, upload current local settings to DB.
  3. **On Change (Logged In)**: Update both PostgreSQL and `shared_preferences` simultaneously.
  4. **On Logout**: Retain settings in `shared_preferences` for the next session.

## Navigation
- Settings page should be a standalone route accessible from both the `AuthGuard` (public) and `MainLayout` (private).
