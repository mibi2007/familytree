import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/auth_repository.dart';

part 'firebase_auth_repository.g.dart';

const List<String> scopes = <String>[
  'https://www.googleapis.com/auth/userinfo.email',
  'https://www.googleapis.com/auth/userinfo.profile',
];

@riverpod
AuthRepository authRepository(Ref ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance, GoogleSignIn.instance); // Use singleton
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  // For Web Phone Auth
  ConfirmationResult? _webConfirmationResult;

  FirebaseAuthRepository(this._auth, this._googleSignIn);

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<Either<String, User>> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown auth error');
    }
  }

  @override
  Future<Either<String, User>> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return right(credential.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown registration error');
    }
  }

  @override
  Future<Either<String, User>> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // v7: For web, we typically use the GoogleAuthProvider directly with popup
        // The google_sign_in package for web (v7) requires the render button flow for ID tokens,
        // but for Firebase Auth specifically, the popup flow is strictly preferred on the web client.
        final provider = GoogleAuthProvider();
        final userCredential = await _auth.signInWithPopup(provider);
        return right(userCredential.user!);
      }

      // v7: Use authenticate() for Mobile (signIn is removed/legacy)
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        return left('Sign in cancelled by user');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      // v7: accessToken is no longer available directly on GoogleSignInAuthentication
      final credential = GoogleAuthProvider.credential(accessToken: null, idToken: googleAuth.idToken);

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      if (user == null) {
        return left('Failed to sign in with Google');
      }

      return right(user);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'popup-closed-by-user') {
        return left('Sign in cancelled by user');
      } else if (error.code == 'account-exists-with-different-credential') {
        return left('An account already exists with the same email address but different sign-in credentials');
      } else {
        return left(error.message ?? 'Google sign-in failed');
      }
    } catch (error) {
      return left('Unexpected error during Google sign-in: ${error.toString()}');
    }
  }

  @override
  Future<Either<String, User>> signInWithGoogleIdToken(String idToken) async {
    try {
      final credential = GoogleAuthProvider.credential(idToken: idToken, accessToken: null);

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        return left('Failed to sign in with Google Token');
      }
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Google Token sign-in failed');
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> signInWithPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    Object? webRecaptchaVerifier,
  }) async {
    try {
      if (kIsWeb) {
        if (webRecaptchaVerifier is! RecaptchaVerifier) {
          return left('Web requires a valid RecaptchaVerifier');
        }
        _webConfirmationResult = await _auth.signInWithPhoneNumber(phoneNumber, webRecaptchaVerifier);
        onCodeSent(_webConfirmationResult!.verificationId);
      } else {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Auto-sign in on Android
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            onVerificationFailed(e.message ?? 'Verification failed');
          },
          codeSent: (String verificationId, int? resendToken) {
            onCodeSent(verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, User>> verifyPhoneCode(String verificationId, String smsCode) async {
    try {
      if (kIsWeb && _webConfirmationResult != null) {
        final result = await _webConfirmationResult!.confirm(smsCode);
        return right(result.user!);
      } else {
        final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        final result = await _auth.signInWithCredential(credential);
        return right(result.user!);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    // Clear any local state for Web Phone Auth
    _webConfirmationResult = null;

    final user = _auth.currentUser;
    if (user != null) {
      final isGoogleLinked = user.providerData.any((userInfo) => userInfo.providerId == 'google.com');
      if (isGoogleLinked) {
        try {
          await _googleSignIn.signOut();
        } catch (_) {
          // Ignore errors if Google Sign In was not initialized
        }
      }
    }

    // This handles Email/Password, Phone, and the Firebase session for Google
    await _auth.signOut();
  }

  @override
  Future<String?> getIdToken() async {
    return await _auth.currentUser?.getIdToken();
  }
}
