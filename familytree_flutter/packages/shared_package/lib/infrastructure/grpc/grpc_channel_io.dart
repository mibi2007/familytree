import 'package:grpc/grpc.dart';

import '../config/app_config.dart';

dynamic getGrpcChannel(AppConfig config) {
  return ClientChannel(
    config.grpcHost,
    port: config.grpcPort,
    options: ChannelOptions(
      credentials: config.useSecureGrpc ? const ChannelCredentials.secure() : const ChannelCredentials.insecure(),
    ),
  );
}
