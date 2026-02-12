/// Signals Infrastructure
///
/// This directory contains Signal-based state management for the FamilyTree app.
/// Signals are being introduced alongside Riverpod during the migration (Phase 1-10).
///
/// ## Directory Structure
///
/// ```
/// lib/app/signals/
/// ├── app_config_signal.dart    - App configuration (POC migration)
/// ├── auth_signals.dart         - Auth state (Phase 3)
/// ├── family_signals.dart       - Family data (Phase 5)
/// ├── chat_signals.dart         - Chat state (Phase 6)
/// └── README.md                 - This file
/// ```
///
/// ## Usage Patterns
///
/// ### Basic Signal
/// ```dart
/// final counter = signal(0);
///
/// // Read value
/// print(counter.value); // 0
///
/// // Update value
/// counter.value = 1;
/// ```
///
/// ### Computed Signal
/// ```dart
/// final doubled = computed(() => counter.value * 2);
/// print(doubled.value); // 2 (automatically updates when counter changes)
/// ```
///
/// ### Effect (Side Effects)
/// ```dart
/// effect(() {
///   print('Counter changed to: ${counter.value}');
/// });
/// ```
///
/// ### In Widgets
/// ```dart
/// class MyWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return Watch((context) {
///       return Text('Counter: ${counter.value}');
///     });
///   }
/// }
/// ```
///
/// ## Migration Status
///
/// - [x] Phase 1: Infrastructure setup + appConfigSignal (POC)
/// - [ ] Phase 3: Auth signals
/// - [x] Phase 5: Family signals
/// - [ ] Phase 6: Chat signals
/// - [ ] Phase 7: Admin signals
///
/// ## Resources
///
/// - [Signals Documentation](https://pub.dev/packages/signals)
/// - [Signals Flutter](https://pub.dev/packages/signals_flutter)
/// - [Migration Plan](../../../../docs/migration/RIVERPOD_TO_SIGNALS_MIGRATION_PLAN.md)
library;

export 'app_config_signal.dart';
export 'auth_signals.dart';
export 'chat_signals.dart';
export 'family_signals.dart';
export 'settings_signal.dart';
export 'theme_signal.dart';
