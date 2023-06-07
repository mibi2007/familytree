import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../data/auth_api.dart';
import '../data/auth_service.dart' as auth_service;
import '../domain/user.dart';

part 'auth_provider.freezed.dart';
part 'auth_state.dart';

final logger = Logger("AuthNotifier");

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApi authApi;

  AuthNotifier._(this.authApi) : super(const AuthState.initial());

  factory AuthNotifier(authApi, knowledgeApi, trackingApi) => AuthNotifier._(authApi);

  void onStateChanged() {
    authApi.authStateChanges().listen((event) async {
      if (event.isSome()) {
        await stateChanged();
      } else {
        state = const AuthState.unAuthenticated();
      }
    }, onError: (err) {
      logger.warning('Error');
      state = const AuthState.unAuthenticated();
    });
  }

  Future<Unit> stateChanged() async {
    // state = const AuthState.loading();
    final userEither = await auth_service.getUser().run(authApi);
    state = userEither.fold((failure) => const AuthState.unAuthenticated(), (user) {
      return user.isEmpty ? const AuthState.authenticated() : const AuthState.unAuthenticated();
    });
    return unit;
  }

  Future<Unit> signInGoogle() async {
    // state = const AuthState.loading();
    await auth_service.signInGoogle().run(authApi);
    stateChanged();
    return unit;
  }

  Future<Unit> signInPhone(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      return unit;
    }
    // regex to check phone number with 10-11 digits
    final phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,11}$)');
    if (!phoneRegExp.hasMatch(phoneNumber)) {
      return unit;
    }

    if (phoneNumber[0] == '0') {
      phoneNumber = phoneNumber.replaceFirst('0', '+84');
    }
    state = const AuthState.loading();
    final resultEither = await auth_service.signInPhone(phoneNumber).run(authApi);
    state = resultEither.isRight() ? const AuthState.verify() : const AuthState.error();
    return unit;
  }

  Future<Unit> signOut() async {
    // state = const AuthState.loading();
    await auth_service.signOut().run(authApi);
    state = const AuthState.unAuthenticated();
    return unit;
  }

  bool isSignedIn() {
    return state == const AuthState.authenticated();
  }

  Future<User> getUser() async {
    return await authApi.getUser();
  }

  Future<Unit> verifyPhone(String verificationCode) async {
    // Regex verify code with 6 numbers
    final verifyCodeRegExp = RegExp(r'(^(?:[0-9]){6}$)');
    if (!verifyCodeRegExp.hasMatch(verificationCode)) {
      return unit;
    }
    state = const AuthState.loading();
    final resultEither = await auth_service.verifyPhone(verificationCode).run(authApi);
    state = resultEither.isRight() ? const AuthState.authenticated() : const AuthState.error();
    return unit;
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier._(ref.read(authApiProvider)));
