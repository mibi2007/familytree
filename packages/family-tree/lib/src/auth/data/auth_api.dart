import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/i_auth.dart';
import '../domain/user.dart';
import 'auth_service.dart' as service;

class AuthApi implements IAuthApi {
  final FirebaseAuth auth;
  final Dio dio;

  AuthApi(this.auth, this.dio);

  late ConfirmationResult confirmationResult;

  @override
  Future<Unit> signInGoogle() async {
    final googleProvider = GoogleAuthProvider();
    await auth.signInWithPopup(googleProvider);
    return unit;
  }

  @override
  Future<Unit> signOut() async {
    await auth.signOut();
    await service.deleteToken();
    return unit;
  }

  Stream<Option> authStateChanges() {
    final stream = auth.authStateChanges();
    return stream.map((fbUser) => optionOf(fbUser?.uid));
  }

  @override
  Future<User> getUser() async {
    return User.fromFirebaseAuth(auth.currentUser!);
  }

  @override
  Future<Unit> signInPhone(String phoneNumber) async {
    confirmationResult = await auth.signInWithPhoneNumber(phoneNumber);
    return unit;
  }

  @override
  Future<Unit> verifyPhone(String verificationCode) async {
    await confirmationResult.confirm(verificationCode);
    return unit;
  }

  @override
  Unit setLanguageCode(String languageCode) {
    auth.setLanguageCode(languageCode);
    return unit;
  }
}

final authApiProvider = Provider<AuthApi>((ref) => AuthApi(
      FirebaseAuth.instance,
      Dio(),
    ));
