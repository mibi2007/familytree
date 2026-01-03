import 'package:shared_package/domain/entities/auth_user.dart';
import 'package:shared_package/shared_package.dart';

abstract class AuthRepository {
  Stream<Option<AuthUser>> watchAuthState();
  
  TaskEither<String, AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  TaskEither<String, AuthUser> signInWithGoogle();

  TaskEither<String, Unit> signOut();

  TaskEither<String, AuthUser> getCurrentUser();
}
