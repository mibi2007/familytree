// Signal-based gRPC Client providers
// Phase 2: Data Layer Migration
// Equivalent to: lib/data/grpc/grpc_client.dart

import 'package:grpc/service_api.dart';
import 'package:signals/signals.dart';

import '../config/app_config.dart';
import '../grpc/generated/proto/auth/v1/auth.pbgrpc.dart';
import '../grpc/generated/proto/chat/v1/chat.pbgrpc.dart';
import '../grpc/generated/proto/family/v1/family.pbgrpc.dart';
import '../grpc/generated/proto/settings/v1/settings.pbgrpc.dart';
import '../grpc/generated/proto/system/v1/system.pbgrpc.dart';
// Conditional import for channel
import '../grpc/grpc_channel_io.dart' if (dart.library.js_interop) '../grpc/grpc_channel_web.dart';
import '../grpc/grpc_interceptor.dart';
import 'auth_repository_signal.dart';

/// Lazy-initialized gRPC channel signal
final grpcChannelSignal = signal<ClientChannel?>(null);

/// Initialize the gRPC channel
void initGrpcChannel(AppConfig config) {
  grpcChannelSignal.value = getGrpcChannel(config) as ClientChannel;
}

// ============================================================================
// Mocks for Testing
// ============================================================================
final mockAuthClientSignal = signal<AuthServiceClient?>(null);
final mockFamilyClientSignal = signal<FamilyServiceClient?>(null);
final mockChatClientSignal = signal<ChatServiceClient?>(null);
final mockSystemClientSignal = signal<SystemServiceClient?>(null);
final mockSettingsClientSignal = signal<SettingsServiceClient?>(null);

// ============================================================================
// Client Signals
// ============================================================================

/// Auth service client signal
final authClientSignal = computed<AuthServiceClient>(() {
  if (mockAuthClientSignal.value != null) return mockAuthClientSignal.value!;

  final channel = grpcChannelSignal.value;
  if (channel == null) {
    throw StateError('gRPC channel not initialized. Call initGrpcChannel() first.');
  }

  final authRepo = authRepositorySignal.value;
  if (authRepo == null) {
    throw StateError('Auth repository not initialized. Call initAuthRepository() first.');
  }

  return AuthServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
});

/// Family service client signal
final familyClientSignal = computed<FamilyServiceClient>(() {
  if (mockFamilyClientSignal.value != null) return mockFamilyClientSignal.value!;

  final channel = grpcChannelSignal.value;
  if (channel == null) {
    throw StateError('gRPC channel not initialized. Call initGrpcChannel() first.');
  }

  final authRepo = authRepositorySignal.value;
  if (authRepo == null) {
    throw StateError('Auth repository not initialized. Call initAuthRepository() first.');
  }

  return FamilyServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
});

/// Chat service client signal
final chatClientSignal = computed<ChatServiceClient>(() {
  if (mockChatClientSignal.value != null) return mockChatClientSignal.value!;

  final channel = grpcChannelSignal.value;
  if (channel == null) {
    throw StateError('gRPC channel not initialized. Call initGrpcChannel() first.');
  }

  final authRepo = authRepositorySignal.value;
  if (authRepo == null) {
    throw StateError('Auth repository not initialized. Call initAuthRepository() first.');
  }

  return ChatServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
});

/// System service client signal
final systemClientSignal = computed<SystemServiceClient>(() {
  if (mockSystemClientSignal.value != null) return mockSystemClientSignal.value!;

  final channel = grpcChannelSignal.value;
  if (channel == null) {
    throw StateError('gRPC channel not initialized. Call initGrpcChannel() first.');
  }

  return SystemServiceClient(channel);
});

/// Settings service client signal
final settingsClientSignal = computed<SettingsServiceClient>(() {
  if (mockSettingsClientSignal.value != null) return mockSettingsClientSignal.value!;

  final channel = grpcChannelSignal.value;
  if (channel == null) {
    throw StateError('gRPC channel not initialized. Call initGrpcChannel() first.');
  }

  final authRepo = authRepositorySignal.value;
  if (authRepo == null) {
    throw StateError('Auth repository not initialized. Call initAuthRepository() first.');
  }

  return SettingsServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
});

/// Dispose gRPC channel and clients
Future<void> disposeGrpcSignals() async {
  final channel = grpcChannelSignal.value;
  if (channel != null) {
    await channel.shutdown();
    grpcChannelSignal.value = null;
  }
}
