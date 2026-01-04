import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Stream<User?> get authStateChanges;
  User? get currentUser;

  Future<Either<String, User>> signInWithEmail(String email, String password);
  Future<Either<String, User>> signUpWithEmail(String email, String password);
  Future<Either<String, User>> signInWithGoogle();
  
  /// Initiates phone verification. 
  /// For Native: Uses verifyPhoneNumber.
  /// For Web: Uses signInWithPhoneNumber with RecaptchaVerifier.
  Future<Either<String, Unit>> signInWithPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onVerificationFailed,
    Object? webRecaptchaVerifier, // Used on Web
  });

  Future<Either<String, User>> verifyPhoneCode(String verificationId, String smsCode);
  Future<void> signOut();
  Future<String?> getIdToken();
}
