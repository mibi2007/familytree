import 'package:flutter_test/flutter_test.dart';
import 'package:shared_package/app/signals/app_config_signal.dart';

void main() {
  group('AppConfigSignal POC Tests', () {
    tearDown(() {
      // Reset to default after each test
      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.local,
        grpcHost: 'localhost',
        grpcPort: 50051,
        useSecureGrpc: false,
      );
    });

    test('appConfigSignal has default local configuration', () {
      final config = appConfigSignal.value;

      expect(config.environment, SharedAppEnvironment.local);
      expect(config.grpcHost, 'localhost');
      expect(config.grpcPort, 50051);
      expect(config.useSecureGrpc, false);
    });

    test('appConfigSignal can be updated', () {
      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.dev,
        grpcHost: 'dev.example.com',
        grpcPort: 443,
        useSecureGrpc: true,
      );

      final config = appConfigSignal.value;
      expect(config.environment, SharedAppEnvironment.dev);
      expect(config.grpcHost, 'dev.example.com');
      expect(config.grpcPort, 443);
      expect(config.useSecureGrpc, true);
    });

    test('isProduction computed signal works correctly', () {
      expect(isProduction.value, false);

      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.prod,
        grpcHost: 'api.example.com',
        grpcPort: 443,
        useSecureGrpc: true,
      );

      expect(isProduction.value, true);
    });

    test('isLocal computed signal works correctly', () {
      expect(isLocal.value, true);

      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.dev,
        grpcHost: 'dev.example.com',
        grpcPort: 443,
      );

      expect(isLocal.value, false);
    });

    test('grpcAddress computed signal generates correct URL', () {
      expect(grpcAddress.value, 'http://localhost:50051');

      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.prod,
        grpcHost: 'api.example.com',
        grpcPort: 443,
        useSecureGrpc: true,
      );

      expect(grpcAddress.value, 'https://api.example.com:443');
    });

    test('computed signals update when source signal changes', () {
      expect(grpcAddress.value, 'http://localhost:50051');

      appConfigSignal.value = SharedAppConfig(
        environment: SharedAppEnvironment.stg,
        grpcHost: 'staging.example.com',
        grpcPort: 8080,
        useSecureGrpc: false,
      );

      // Computed signal should automatically update
      expect(grpcAddress.value, 'http://staging.example.com:8080');
      expect(isProduction.value, false);
      expect(isLocal.value, false);
    });
  });
}
