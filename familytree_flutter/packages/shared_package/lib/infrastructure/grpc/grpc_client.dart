import 'package:grpc/service_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../repositories/firebase_auth_repository.dart';
import 'generated/proto/auth/v1/auth.pbgrpc.dart';
import 'generated/proto/chat/v1/chat.pbgrpc.dart';
import 'generated/proto/family/v1/family.pbgrpc.dart';
import 'grpc_channel_io.dart' if (dart.library.js_interop) 'grpc_channel_web.dart';
import 'grpc_interceptor.dart';

part 'grpc_client.g.dart';

@riverpod
ClientChannel grpcChannel(Ref ref) {
  final config = ref.watch(appConfigProvider);
  return getGrpcChannel(config) as ClientChannel;
}

@riverpod
AuthServiceClient authClient(Ref ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authRepo = ref.watch(authRepositoryProvider);

  return AuthServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
}

@riverpod
FamilyServiceClient familyClient(Ref ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authRepo = ref.watch(authRepositoryProvider);

  return FamilyServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
}

@riverpod
ChatServiceClient chatClient(Ref ref) {
  final channel = ref.watch(grpcChannelProvider);
  final authRepo = ref.watch(authRepositoryProvider);

  return ChatServiceClient(channel, interceptors: [GrpcAuthInterceptor(authRepo)]);
}
