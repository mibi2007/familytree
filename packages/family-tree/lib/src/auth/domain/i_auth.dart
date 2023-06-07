import 'package:fpdart/fpdart.dart';

import 'user.dart';

abstract interface class IAuthApi {
  Future<Unit> signInGoogle();
  Future<Unit> signInPhone(String phoneNumber);
  Future<Unit> verifyPhone(String verificationCode);
  Future<User> getUser();
  Future<Unit> signOut();
  Unit setLanguageCode(String languageCode);
}
