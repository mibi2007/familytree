// Signal-based App Configuration
// This is a proof-of-concept migration from Riverpod to Signals
// Original: lib/data/config/app_config.dart (appConfigProvider)

import 'package:signals/signals.dart';

enum SharedAppEnvironment { local, dev, stg, prod }

class SharedAppConfig {
  final SharedAppEnvironment environment;
  final String grpcHost;
  final int grpcPort;
  final bool useSecureGrpc;

  SharedAppConfig({
    required this.environment,
    required this.grpcHost,
    required this.grpcPort,
    this.useSecureGrpc = false,
  });
}

/// App configuration signal
///
/// This signal provides application configuration settings.
/// During migration, this coexists with the Riverpod version.
///
/// Usage:
/// ```dart
/// // Read the config
/// final config = appConfigSignal.value;
/// print(config.grpcHost); // localhost
///
/// // Update the config (if needed)
/// appConfigSignal.value = SharedAppConfig(
///   environment: SharedAppEnvironment.dev,
///   grpcHost: 'dev.example.com',
///   grpcPort: 443,
///   useSecureGrpc: true,
/// );
/// ```
///
final appConfigSignal = signal<SharedAppConfig>(
  SharedAppConfig(
    environment: SharedAppEnvironment.local,
    grpcHost: 'localhost',
    grpcPort: 50051,
    useSecureGrpc: false,
  ),
);

/// Computed signal for checking if running in production
final isProduction = computed(() => appConfigSignal.value.environment == SharedAppEnvironment.prod);

/// Computed signal for checking if running locally
final isLocal = computed(() => appConfigSignal.value.environment == SharedAppEnvironment.local);

/// Computed signal for full gRPC address
final grpcAddress = computed(() {
  final config = appConfigSignal.value;
  final protocol = config.useSecureGrpc ? 'https' : 'http';
  return '$protocol://${config.grpcHost}:${config.grpcPort}';
});
