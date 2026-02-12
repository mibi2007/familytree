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
          lifetimeSeconds: Int64(3600), // 1 hour
        ),
      );

      if (!ref.mounted) return;

      state = AsyncData(token);
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError(e, st);
    }
  }
}
