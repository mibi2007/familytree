import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
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

  AuthNotifier._(this.authApi) : super(AuthState.initial());

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
    Either<String, bool> hasAccess = left('');
    if (userEither.isRight()) {
      hasAccess = await auth_service.hasAccess(userEither.getOrElse((l) => User.empty()).email).run(authApi);
    }
    state = userEither.fold((failure) => const AuthState.unAuthenticated(), (user) {
      return hasAccess.isRight() && hasAccess.getOrElse((l) => false)
          ? const AuthState.authenticatedHasAccess()
          : const AuthState.authenticatedNoAccess();
    });
    return unit;
  }

  Future<Unit> signIn() async {
    // state = const AuthState.loading();
    await authApi.signInGoogle();
    stateChanged();
    return unit;
  }

  Future<Unit> signOut() async {
    // state = const AuthState.loading();
    await auth_service.signOut().run(authApi);
    state = const AuthState.unAuthenticated();
    return unit;
  }

  bool isSignedIn() {
    return state is AuthenticatedNoAccess || state is AuthenticatedHasAccess;
  }

  Future<User> getUser() async {
    return await authApi.getUser();
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier._(ref.read(authApiProvider)));

final authApiProvider = Provider<AuthApi>(
  (ref) => AuthApi(FirebaseAuth.instance, Dio()),
);
