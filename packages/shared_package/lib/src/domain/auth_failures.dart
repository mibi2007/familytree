import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure<T> with _$AuthFailure<T> {
  const factory AuthFailure.cancelByUser() = CancelByUser;
  const factory AuthFailure.serverError() = AuthServerError;
  const factory AuthFailure.emailAlreadyUsed() = EmailAlreadyUsed;
  const factory AuthFailure.invalidEmailPassword() = InvalidEmailPassword;
  const factory AuthFailure.invalidEmail() = InvalidEmail;
  const factory AuthFailure.invalidPassword() = InvalidPassword;
  const factory AuthFailure.invalidCode() = InvalidCode;
  const factory AuthFailure.emailNotFound() = EmailNotFound;
  const factory AuthFailure.limitExceededException() = LimitExceededException;
}
