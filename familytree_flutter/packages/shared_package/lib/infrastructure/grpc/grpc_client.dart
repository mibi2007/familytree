import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../repositories/firebase_auth_repository.dart';
import 'generated/proto/auth/v1/auth.pbgrpc.dart';
import 'generated/proto/family/v1/family.pbgrpc.dart';
import 'grpc_interceptor.dart';

part 'grpc_client.g.dart';

@riverpod
ClientChannel grpcChannel(Ref ref) {
  final config = ref.watch(appConfigProvider);

  return ClientChannel(
    config.grpcHost,
    port: config.grpcPort,
    options: ChannelOptions(
      credentials: config.useSecureGrpc ? const ChannelCredentials.secure() : const ChannelCredentials.insecure(),
    ),
  );
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
