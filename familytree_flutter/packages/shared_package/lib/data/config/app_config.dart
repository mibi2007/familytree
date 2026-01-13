import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum AppEnvironment { local, dev, stg, prod }

class AppConfig {
  final AppEnvironment environment;
  final String grpcHost;
  final int grpcPort;
  final bool useSecureGrpc;

  AppConfig({required this.environment, required this.grpcHost, required this.grpcPort, this.useSecureGrpc = false});
}

@riverpod
AppConfig appConfig(Ref ref) {
  // Default to local/dev settings
  return AppConfig(environment: AppEnvironment.local, grpcHost: 'localhost', grpcPort: 50051, useSecureGrpc: false);
}
