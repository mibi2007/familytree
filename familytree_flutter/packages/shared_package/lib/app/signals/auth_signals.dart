// Signal-based Auth State Management
// Phase 3: Auth Feature Migration
// Equivalent to: lib/app/providers/auth_provider.dart

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:signals/signals.dart';

import '../../data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import '../../data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import '../../data/repositories/firebase_auth_repository.dart';
import '../../data/signals/auth_repository_signal.dart';
import '../../data/signals/grpc_client_signals.dart';

/// Firebase auth state stream  signal
///
/// Streams the current Firebase authentication state.
/// Equivalent to: `authStateProvider`
///
/// Usage:
/// ```dart
/// Watch((context) {
///   return authUserSignal.value.map(
///     data: (user) => user != null ? HomePage() : LoginPage(),
///     loading: () => LoadingPage(),
///     error: (err, stack) => ErrorPage(err),
///   );
/// });
/// ```
final authUserSignal = streamSignal<fb.User?>(() {
  final repo = authRepositorySignal.value;
  return repo?.authStateChanges ?? const Stream.empty();
});

/// Computed signal for checking if user is authenticated
///
/// Reactively updates when auth state changes.
final isAuthenticatedSignal = computed<bool>(() {
  return authUserSignal.value.map(data: (user) => user != null, loading: () => false, error: (_, _) => false);
});

/// Current user signal (computed from auth stream)
///
/// Returns the current user or null.
/// For full user profile, use `currentUserProfileSignal`.
final currentUserSignal = computed<fb.User?>(() {
  return authUserSignal.value.map(data: (user) => user, loading: () => null, error: (_, _) => null);
});

/// Current user profile signal (full backend profile)
///
/// Fetches the full user profile from backend.
/// Equivalent to: `currentUser` provider
final currentUserProfileSignal = futureSignal<common_proto.UserProfile?>(() async {
  final user = authUserSignal.value.value;
  if (user == null) return null;

  try {
    final client = authClientSignal.value;
    return await client.getUserProfile(auth_proto.GetUserProfileRequest(userId: user.uid));
  } catch (e) {
    return null;
  }
});

/// Admin status signal - fetches from backend
///
/// Checks if current user has admin role.
/// Equivalent to: `adminStatusProvider`
final adminStatusSignal = futureSignal<auth_proto.AuthStatusResponse?>(() async {
  final user = authUserSignal.value.value;
  if (user == null) {
    return null;
  }

  try {
    final client = authClientSignal.value;
    return await client.getAuthStatus(Empty());
  } catch (e) {
    return null;
  }
});

/// User profile signal factory
///
/// Creates a future signal for fetching a specific user's profile.
/// Equivalent to: `userProfileProvider(userId)`
FutureSignal<common_proto.UserProfile> getUserProfileSignal(String userId) {
  return futureSignal(() async {
    final client = authClientSignal.value;
    return await client.getUserProfile(auth_proto.GetUserProfileRequest(userId: userId));
  });
}

// ... (other parts of file are fine or need updates inside controller)

class AuthSignalsController {
  // ... (previous properties)
  final _isLoading = signal<bool>(false);
  final _error = signal<String?>(null);

  bool get isLoading => _isLoading.value;
  String? get error => _error.value;
  Signal<bool> get isLoadingSignal => _isLoading;
  Signal<String?> get errorSignal => _error;

  /// Helper to get repo or throw
  FirebaseAuthRepository _getRepo() {
    final repo = authRepositorySignal.value;
    if (repo == null) {
      throw Exception('Auth repository not initialized');
    }
    return repo;
  }

  /// Sign in with email and password
  Future<void> signInWithEmail(String email, String password) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.signInWithEmail(email, password);

      await result.fold(
        (error) async {
          _error.value = error;
        },
        (user) async {
          await _syncProfile(user);
        },
      );
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail(String email, String password) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.signUpWithEmail(email, password);

      await result.fold(
        (error) async {
          _error.value = error;
        },
        (user) async {
          await _syncProfile(user);
        },
      );
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.signInWithGoogle();

      await result.fold(
        (error) async {
          _error.value = error;
        },
        (user) async {
          await _syncProfile(user);
        },
      );
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with phone
  Future<void> signInWithPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    Object? webRecaptchaVerifier,
  }) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.signInWithPhone(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onVerificationFailed: onVerificationFailed,
        webRecaptchaVerifier: webRecaptchaVerifier,
      );

      result.fold((error) => _error.value = error, (_) => null);
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Verify phone code
  Future<void> verifyPhoneCode(String verificationId, String smsCode) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.verifyPhoneCode(verificationId, smsCode);

      await result.fold(
        (error) async {
          _error.value = error;
        },
        (user) async {
          await _syncProfile(user);
        },
      );
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign in with Google ID token (for web)
  Future<void> signInWithGoogleIdToken(String idToken) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      final result = await repo.signInWithGoogleIdToken(idToken);

      await result.fold(
        (error) async {
          _error.value = error;
        },
        (user) async {
          await _syncProfile(user);
        },
      );
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final repo = _getRepo();
      await repo.signOut();
    } catch (e) {
      _error.value = e.toString();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Delete account (request account deletion)
  Future<void> deleteAccount() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final client = authClientSignal.value;
      await client.requestAccountDeletion(auth_proto.RequestAccountDeletionRequest());
      // After requesting deletion, sign out the user
      await signOut();
    } catch (e) {
      _error.value = e.toString();
      _isLoading.value = false;
    }
  }

  /// Revoke own admin access
  Future<void> revokeSelf() async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final user = authUserSignal.value.value;
      if (user == null) throw Exception('Not authenticated');

      final client = authClientSignal.value;
      // Revoke our own role
      await client.revokeAdminRole(auth_proto.RevokeAdminRoleRequest(userId: user.uid));

      // Force sign out immediately
      await signOut();
    } catch (e) {
      _error.value = e.toString();
      _isLoading.value = false;
    }
  }

  /// Sync user profile to backend
  Future<void> _syncProfile(fb.User user) async {
    try {
      final client = authClientSignal.value;
      final request = auth_proto.SyncUserProfileRequest(
        displayName: user.displayName ?? '',
        photoUrl: user.photoURL ?? '',
      );
      await client.syncUserProfile(request);
    } catch (e) {
      _error.value = 'Profile sync failed: $e';
    }
  }
}

/// Global auth controller instance
///
/// Usage:
/// ```dart
/// await authSignalsController.signInWithEmail(email, password);
/// ```
final authSignalsController = AuthSignalsController();
