import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_auth.dart';
import '../domain/user.dart';
import 'auth_service.dart' as service;

class AuthApi implements IAuthApi {
  final FirebaseAuth auth;
  final Dio dio;

  AuthApi(this.auth, this.dio);

  @override
  signInGoogle() async {
    final googleProvider = GoogleAuthProvider();
    await auth.signInWithPopup(googleProvider);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', await auth.currentUser?.getIdToken() ?? '');
    return unit;
  }

  @override
  signOut() async {
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
  Future<bool> checkACL(String email) async {
    final aclList = await dio.get(
        'https://mimetic-slice-377808-default-rtdb.asia-southeast1.firebasedatabase.app/user_access_control_list.json');
    return (aclList.data as List<dynamic>).filter((e) => e['email'] == 'binh@t7.sg').isNotEmpty;
  }
}
