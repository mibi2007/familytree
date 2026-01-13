import 'package:fixnum/fixnum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';

part 'invite_provider.g.dart';

@riverpod
class InviteController extends _$InviteController {
  @override
  FutureOr<auth_proto.InviteToken?> build() => null;

  Future<void> generateToken(auth_proto.TokenPurpose purpose) async {
    state = const AsyncLoading();
    try {
      final client = ref.read(authClientProvider);

      final token = await client.generateInviteToken(
        auth_proto.GenerateInviteTokenRequest(
          purpose: purpose,
          lifetimeSeconds: Int64(86400 * 7), // 7 days
        ),
      );

      state = AsyncData(token);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
