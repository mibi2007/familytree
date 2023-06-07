import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:shared_package/shared_package.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_auth.dart';
import '../domain/user.dart';
import 'auth_api.dart';

Future<Unit> deleteToken() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  return unit;
}

Reader<AuthApi, Future<Either<String, Unit>>> signOut() {
  return Reader(
    (api) => _signOut(api).run(),
  );
}

TaskEither<String, Unit> _signOut(AuthApi api) => TaskEither.tryCatch(
      () => api.signOut(),
      (err, trace) {
        return "Error signout";
      },
    );

Reader<IAuthApi, Future<Either<String, User>>> getUser() {
  return Reader(
    (api) => _getUser(api).run(),
  );
}

TaskEither<String, User> _getUser(
  IAuthApi api,
) =>
    TaskEither.tryCatch(
      () => api.getUser(),
      (error, __) {
        return 'getUserFail';
      },
    );

Reader<IAuthApi, Future<Either<AuthFailure, Unit>>> signInGoogle() {
  return Reader(
    (api) => _signInGoogle(api).run(),
  );
}

TaskEither<AuthFailure, Unit> _signInGoogle(
  IAuthApi api,
) =>
    TaskEither.tryCatch(
      () => api.signInGoogle(),
      (error, __) {
        if (error is AuthFailure) {
          return error;
        }
        return const AuthFailure.serverError();
      },
    );

Reader<IAuthApi, Future<Either<AuthFailure, Unit>>> signInPhone(String phoneNumber) {
  return Reader(
    (api) => _signInPhone(api, phoneNumber).run(),
  );
}

TaskEither<AuthFailure, Unit> _signInPhone(
  IAuthApi api,
  String phoneNumber,
) =>
    TaskEither.tryCatch(
      () => api.signInPhone(phoneNumber),
      (error, __) {
        if (error is FirebaseAuthException) {
          return switch (error.code) {
            'unknown' => const AuthFailure.invalidPhone(),
            _ => const AuthFailure.serverError(),
          };
        }
        return const AuthFailure.serverError();
      },
    );

Reader<IAuthApi, Future<Either<AuthFailure, Unit>>> verifyPhone(String verificationCode) {
  return Reader(
    (api) => _verifyPhone(api, verificationCode).run(),
  );
}

TaskEither<AuthFailure, Unit> _verifyPhone(
  IAuthApi api,
  String verificationCode,
) =>
    TaskEither.tryCatch(
      () => api.verifyPhone(verificationCode),
      (error, __) {
        if (error is FirebaseAuthException) {
          return switch (error.code) {
            'unknown' => const AuthFailure.invalidCode(),
            _ => const AuthFailure.serverError(),
          };
        }
        return const AuthFailure.serverError();
      },
    );
