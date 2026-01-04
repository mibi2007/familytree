import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure<T> with _$AuthFailure<T> {
  const factory AuthFailure.cancelByUser() = CancelByUser;
  const factory AuthFailure.serverError() = AuthServerError;
  const factory AuthFailure.emailAlreadyUsed() = EmailAlreadyUsed;
  const factory AuthFailure.idAlreadyUsed() = IdAlreadyUsed;
  const factory AuthFailure.invalidEmailPassword() = InvalidEmailPassword;
  const factory AuthFailure.invalidEmail() = InvalidEmail;
  const factory AuthFailure.invalidPhone() = InvalidPhone;
  const factory AuthFailure.invalidPassword() = InvalidPassword;
  const factory AuthFailure.invalidCode() = InvalidCode;
  const factory AuthFailure.userNotFound() = UserNotFound;
  const factory AuthFailure.limitExceededException() = LimitExceededException;
  const factory AuthFailure.invalidParam(String param) = InvalidParam;
  const factory AuthFailure.customTokenMismatch(String param) = CustomTokenMismatch;
  const factory AuthFailure.invalidCustomToken(String param) = InvalidCustomToken;
  const factory AuthFailure.emailAlreadyConfirmed() = EmailAlreadyConfirmed;
  const factory AuthFailure.missingEmail() = MissingEmail;
  const factory AuthFailure.invalidToken() = InvalidToken;
  const factory AuthFailure.expiredToken() = ExpiredToken;
  const factory AuthFailure.accountExistsWithDifferentCredential(String email) = AccountExistsWithDifferentCredential;
  const factory AuthFailure.pluginNotInitialized(String provider) = PluginNotInitialized;
}
