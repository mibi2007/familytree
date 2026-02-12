import 'package:flutter_test/flutter_test.dart';
import 'package:shared_package/data/config/app_config.dart';
import 'package:shared_package/data/signals/grpc_client_signals.dart';

void main() {
  group('gRPC Client Signals', () {
    late AppConfig testConfig;

    setUp(() {
      // Create test config
      testConfig = AppConfig(
        environment: AppEnvironment.local,
        grpcHost: 'localhost',
        grpcPort: 50051,
        useSecureGrpc: false,
      );
    });

    tearDown(() async {
      // Clean up gRPC resources
      await disposeGrpcSignals();
    });

    test('grpcChannelSignal can be initialized', () {
      initGrpcChannel(testConfig);

      final channel = grpcChannelSignal.value;
      expect(channel, isNotNull);
    });

    test('service clients throw error if channel not initialized', () {
      // Don't call initGrpcChannel()

      expect(() => authClientSignal.value, throwsStateError);
    });

    test('disposeGrpcSignals cleans up resources', () async {
      initGrpcChannel(testConfig);
      expect(grpcChannelSignal.value, isNotNull);

      await disposeGrpcSignals();
      expect(grpcChannelSignal.value, isNull);
    });
  });
}
