# Settings - Requirements

## Overview
Enable users to customize their app experience, including language and theme preferences.

## Functional Requirements
- **Theme Selection**:
  - Light Mode.
  - Dark Mode.
  - System Mode (Auto-sync with device).
- **Language Selection**:
  - Vietnamese (Primary).
  - English (Secondary).
- **Notification Settings**:
  - Opt-in/out for **Email** and **Device (Push)** notifications.
- **Accessibility**:
  - Settings must be accessible **unauthenticated** (from the Login screen) and **authenticated** (from the main profile/drawer).
- **Persistence & Synchronization**:
  - **Local**: Preferences are saved locally via `shared_preferences`.
  - **Cloud Sync**: 
    - When authenticated, settings are retrieved from and saved to the **PostgreSQL** database.
    - Upon login, the local settings should be synchronized with the database settings (Database takes precedence).
