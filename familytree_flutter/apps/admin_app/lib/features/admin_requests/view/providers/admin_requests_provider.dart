import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import 'package:shared_package/shared_package.dart';

part 'admin_requests_provider.g.dart';

@riverpod
Future<List<auth_proto.AdminAccessRequest>> pendingRequests(Ref ref) async {
  final client = ref.read(authClientProvider);
  final response = await client.listAdminRequests(
    auth_proto.ListAdminRequestsRequest(
      filterStatus: auth_proto.RequestStatus.REQUEST_STATUS_PENDING,
      pagination: common_proto.PaginatedRequest(pageSize: 50),
    ),
  );
  return response.requests;
}

@riverpod
class AdminRequestsController extends _$AdminRequestsController {
  @override
  FutureOr<void> build() {}

  Future<void> reviewRequest(String requestId, bool approve) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(authClientProvider);
      final status = approve
          ? auth_proto.RequestStatus.REQUEST_STATUS_APPROVED
          : auth_proto.RequestStatus.REQUEST_STATUS_REJECTED;

      await client.reviewAdminRequest(auth_proto.ReviewAdminRequestRequest(requestId: requestId, decision: status));

      // Refresh the list
      ref.invalidate(pendingRequestsProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
