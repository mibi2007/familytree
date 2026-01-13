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

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithEmail(email, password);

    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signUpWithEmail(email, password);
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signInWithGoogle() async {
    print('RUN');
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.signInWithGoogle();
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
    state = result.fold((error) => AsyncError(error, StackTrace.current), (_) => const AsyncData(null));
  }

  Future<void> verifyPhoneCode(String verificationId, String smsCode) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);
    final result = await repo.verifyPhoneCode(verificationId, smsCode);
    await result.fold(
      (error) async => state = AsyncError(error, StackTrace.current),
      (user) async => await _syncProfile(user),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }

  Future<void> _syncProfile(fb.User user) async {
    try {
      final client = ref.read(authClientProvider);
      await client.syncUserProfile(
        auth_proto.SyncUserProfileRequest(displayName: user.displayName ?? '', photoUrl: user.photoURL ?? ''),
      );
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError('Profile sync failed: $e', StackTrace.current);
    }
  }
}
