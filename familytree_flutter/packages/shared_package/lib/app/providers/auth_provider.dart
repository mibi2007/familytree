import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import '../../data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import '../../data/grpc/grpc_client.dart';
import '../../data/repositories/firebase_auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<fb.User?> authState(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
Future<auth_proto.AuthStatusResponse> adminStatus(Ref ref) async {
  final user = await ref.watch(authStateProvider.future);
  if (user == null) {
    throw Exception('User not authenticated');
  }

  final client = ref.read(authClientProvider);
  return client.getAuthStatus(Empty());
}

@riverpod
Future<common_proto.UserProfile> userProfile(Ref ref, String userId) async {
  final client = ref.read(authClientProvider);
  return client.getUserProfile(auth_proto.GetUserProfileRequest(userId: userId));
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithEmail(email, password);

    if (!ref.mounted) return;
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signUpWithEmail(email, password);

    if (!ref.mounted) return;
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithGoogle();

    if (!ref.mounted) return;
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signInWithPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    Object? webRecaptchaVerifier,
  }) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithPhone(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onVerificationFailed: onVerificationFailed,
      webRecaptchaVerifier: webRecaptchaVerifier,
    );
    if (!ref.mounted) return;
    state = result.fold((error) => AsyncError(error, StackTrace.current), (_) => const AsyncData(null));
  }

  Future<void> verifyPhoneCode(String verificationId, String smsCode) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.verifyPhoneCode(verificationId, smsCode);

    if (!ref.mounted) return;
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).signOut();
    if (!ref.mounted) return;
    state = const AsyncData(null);
  }

  Future<void> _syncProfile(fb.User user) async {
    try {
      final client = ref.read(authClientProvider);
      await client.syncUserProfile(
        auth_proto.SyncUserProfileRequest(displayName: user.displayName ?? '', photoUrl: user.photoURL ?? ''),
      );
      if (!ref.mounted) return;
      state = const AsyncData(null);
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError('Profile sync failed: $e', st);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    try {
      final client = ref.read(authClientProvider);
      await client.requestAccountDeletion(auth_proto.RequestAccountDeletionRequest());
      if (!ref.mounted) return;
      // After requesting deletion, sign out the user
      await signOut();
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError(e, st);
    }
  }

  Future<void> revokeSelf() async {
    state = const AsyncLoading();
    try {
      final user = await ref.read(authStateProvider.future);
      if (user == null) throw Exception('Not authenticated');

      final client = ref.read(authClientProvider);
      // Revoke our own role
      await client.revokeAdminRole(auth_proto.RevokeAdminRoleRequest(userId: user.uid));

      if (!ref.mounted) return;

      // Force sign out immediately
      await signOut();
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError(e, st);
    }
  }
}

@riverpod
Future<common_proto.UserProfile?> currentUser(Ref ref) async {
  final authUser = await ref.watch(authStateProvider.future);
  if (authUser == null) return null;

  try {
    final client = ref.read(authClientProvider);
    return await client.getUserProfile(auth_proto.GetUserProfileRequest(userId: authUser.uid));
  } catch (e) {
    return null;
  }
}
