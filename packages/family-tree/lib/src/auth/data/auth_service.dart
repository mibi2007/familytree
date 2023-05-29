import 'package:fpdart/fpdart.dart';
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

Reader<IAuthApi, Future<Either<String, bool>>> hasAccess(String email) {
  return Reader(
    (api) => _hasAccess(email, api).run(),
  );
}

TaskEither<String, bool> _hasAccess(
  String email,
  IAuthApi api,
) =>
    TaskEither.tryCatch(
      () => api.checkACL(email),
      (error, __) {
        return 'getAccess';
      },
    );
