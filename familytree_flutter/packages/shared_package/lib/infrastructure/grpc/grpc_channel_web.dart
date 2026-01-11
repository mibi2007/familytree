import 'package:grpc/grpc_web.dart';

import '../config/app_config.dart';

dynamic getGrpcChannel(AppConfig config) {
  return GrpcWebClientChannel.xhr(Uri.parse('http://${config.grpcHost}:9090'));
}
