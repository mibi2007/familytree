# Notifications - Architecture

## DDD Layers

### 1. Domain Layer
- **Entities**: `Notification`, `ReminderConfig`.
- **Value Objects**: `NotificationType`, `DeliveryChannel`.
- **Interfaces**: `INotificationService`.

### 2. Infrastructure Layer
- **Implementations**:
  - `FCMNotificationService`.
  - `EmailNotificationService`.
- **Repository**: `ReminderRepository` (Postgres).

### 3. Application Layer
- **Providers**: `notificationSettingsProvider`.
- **Use Cases**: `ConfigureReminderUseCase`, `UpdatePushTokenUseCase`.

### 4. Presentation Layer
- **UI**:
  - `ReminderShortcutSwitch`: In member detail view.
  - `NotificationSettingsSection`: In settings page.
  - `DaysBeforePicker`: Numerical input for reminder advance notice.
