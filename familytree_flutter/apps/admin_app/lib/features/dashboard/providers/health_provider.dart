import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/data/grpc/generated/proto/system/v1/system.pbgrpc.dart';
import 'package:shared_package/data/grpc/grpc_client.dart';

part 'health_provider.g.dart';

@riverpod
Future<HealthCheckResponse> healthStatus(Ref ref) async {
  final client = ref.watch(systemClientProvider);
  return await client.getHealthStatus(HealthCheckRequest());
}
