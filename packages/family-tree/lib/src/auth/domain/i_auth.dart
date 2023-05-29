import 'package:fpdart/fpdart.dart';

import 'user.dart';

abstract interface class IAuthApi {
  Future<Unit> signInGoogle();
  Future<User> getUser();
  Future<Unit> signOut();

  Future<bool> checkACL(String email);
}
