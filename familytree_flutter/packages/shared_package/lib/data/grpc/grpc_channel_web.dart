import 'package:grpc/grpc_web.dart';

import '../config/app_config.dart';

dynamic getGrpcChannel(AppConfig config) {
  final scheme = config.useSecureGrpc ? 'https' : 'http';
  return GrpcWebClientChannel.xhr(Uri.parse('$scheme://${config.grpcHost}:${config.grpcPort}'));
}
