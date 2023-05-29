// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthFailure<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthFailureCopyWith<T, $Res> {
  factory $AuthFailureCopyWith(
          AuthFailure<T> value, $Res Function(AuthFailure<T>) then) =
      _$AuthFailureCopyWithImpl<T, $Res, AuthFailure<T>>;
}

/// @nodoc
class _$AuthFailureCopyWithImpl<T, $Res, $Val extends AuthFailure<T>>
    implements $AuthFailureCopyWith<T, $Res> {
  _$AuthFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CancelByUserCopyWith<T, $Res> {
  factory _$$CancelByUserCopyWith(
          _$CancelByUser<T> value, $Res Function(_$CancelByUser<T>) then) =
      __$$CancelByUserCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$CancelByUserCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$CancelByUser<T>>
    implements _$$CancelByUserCopyWith<T, $Res> {
  __$$CancelByUserCopyWithImpl(
      _$CancelByUser<T> _value, $Res Function(_$CancelByUser<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CancelByUser<T> implements CancelByUser<T> {
  const _$CancelByUser();

  @override
  String toString() {
    return 'AuthFailure<$T>.cancelByUser()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CancelByUser<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return cancelByUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return cancelByUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (cancelByUser != null) {
      return cancelByUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return cancelByUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return cancelByUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (cancelByUser != null) {
      return cancelByUser(this);
    }
    return orElse();
  }
}

abstract class CancelByUser<T> implements AuthFailure<T> {
  const factory CancelByUser() = _$CancelByUser<T>;
}

/// @nodoc
abstract class _$$AuthServerErrorCopyWith<T, $Res> {
  factory _$$AuthServerErrorCopyWith(_$AuthServerError<T> value,
          $Res Function(_$AuthServerError<T>) then) =
      __$$AuthServerErrorCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$AuthServerErrorCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$AuthServerError<T>>
    implements _$$AuthServerErrorCopyWith<T, $Res> {
  __$$AuthServerErrorCopyWithImpl(
      _$AuthServerError<T> _value, $Res Function(_$AuthServerError<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthServerError<T> implements AuthServerError<T> {
  const _$AuthServerError();

  @override
  String toString() {
    return 'AuthFailure<$T>.serverError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthServerError<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return serverError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return serverError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class AuthServerError<T> implements AuthFailure<T> {
  const factory AuthServerError() = _$AuthServerError<T>;
}

/// @nodoc
abstract class _$$EmailAlreadyUsedCopyWith<T, $Res> {
  factory _$$EmailAlreadyUsedCopyWith(_$EmailAlreadyUsed<T> value,
          $Res Function(_$EmailAlreadyUsed<T>) then) =
      __$$EmailAlreadyUsedCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$EmailAlreadyUsedCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$EmailAlreadyUsed<T>>
    implements _$$EmailAlreadyUsedCopyWith<T, $Res> {
  __$$EmailAlreadyUsedCopyWithImpl(
      _$EmailAlreadyUsed<T> _value, $Res Function(_$EmailAlreadyUsed<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EmailAlreadyUsed<T> implements EmailAlreadyUsed<T> {
  const _$EmailAlreadyUsed();

  @override
  String toString() {
    return 'AuthFailure<$T>.emailAlreadyUsed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmailAlreadyUsed<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return emailAlreadyUsed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return emailAlreadyUsed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (emailAlreadyUsed != null) {
      return emailAlreadyUsed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return emailAlreadyUsed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return emailAlreadyUsed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (emailAlreadyUsed != null) {
      return emailAlreadyUsed(this);
    }
    return orElse();
  }
}

abstract class EmailAlreadyUsed<T> implements AuthFailure<T> {
  const factory EmailAlreadyUsed() = _$EmailAlreadyUsed<T>;
}

/// @nodoc
abstract class _$$InvalidEmailPasswordCopyWith<T, $Res> {
  factory _$$InvalidEmailPasswordCopyWith(_$InvalidEmailPassword<T> value,
          $Res Function(_$InvalidEmailPassword<T>) then) =
      __$$InvalidEmailPasswordCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InvalidEmailPasswordCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$InvalidEmailPassword<T>>
    implements _$$InvalidEmailPasswordCopyWith<T, $Res> {
  __$$InvalidEmailPasswordCopyWithImpl(_$InvalidEmailPassword<T> _value,
      $Res Function(_$InvalidEmailPassword<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InvalidEmailPassword<T> implements InvalidEmailPassword<T> {
  const _$InvalidEmailPassword();

  @override
  String toString() {
    return 'AuthFailure<$T>.invalidEmailPassword()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidEmailPassword<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return invalidEmailPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return invalidEmailPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidEmailPassword != null) {
      return invalidEmailPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return invalidEmailPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return invalidEmailPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidEmailPassword != null) {
      return invalidEmailPassword(this);
    }
    return orElse();
  }
}

abstract class InvalidEmailPassword<T> implements AuthFailure<T> {
  const factory InvalidEmailPassword() = _$InvalidEmailPassword<T>;
}

/// @nodoc
abstract class _$$InvalidEmailCopyWith<T, $Res> {
  factory _$$InvalidEmailCopyWith(
          _$InvalidEmail<T> value, $Res Function(_$InvalidEmail<T>) then) =
      __$$InvalidEmailCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InvalidEmailCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$InvalidEmail<T>>
    implements _$$InvalidEmailCopyWith<T, $Res> {
  __$$InvalidEmailCopyWithImpl(
      _$InvalidEmail<T> _value, $Res Function(_$InvalidEmail<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InvalidEmail<T> implements InvalidEmail<T> {
  const _$InvalidEmail();

  @override
  String toString() {
    return 'AuthFailure<$T>.invalidEmail()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidEmail<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return invalidEmail();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return invalidEmail?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return invalidEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return invalidEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidEmail != null) {
      return invalidEmail(this);
    }
    return orElse();
  }
}

abstract class InvalidEmail<T> implements AuthFailure<T> {
  const factory InvalidEmail() = _$InvalidEmail<T>;
}

/// @nodoc
abstract class _$$InvalidPasswordCopyWith<T, $Res> {
  factory _$$InvalidPasswordCopyWith(_$InvalidPassword<T> value,
          $Res Function(_$InvalidPassword<T>) then) =
      __$$InvalidPasswordCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InvalidPasswordCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$InvalidPassword<T>>
    implements _$$InvalidPasswordCopyWith<T, $Res> {
  __$$InvalidPasswordCopyWithImpl(
      _$InvalidPassword<T> _value, $Res Function(_$InvalidPassword<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InvalidPassword<T> implements InvalidPassword<T> {
  const _$InvalidPassword();

  @override
  String toString() {
    return 'AuthFailure<$T>.invalidPassword()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidPassword<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return invalidPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return invalidPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidPassword != null) {
      return invalidPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return invalidPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return invalidPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidPassword != null) {
      return invalidPassword(this);
    }
    return orElse();
  }
}

abstract class InvalidPassword<T> implements AuthFailure<T> {
  const factory InvalidPassword() = _$InvalidPassword<T>;
}

/// @nodoc
abstract class _$$InvalidCodeCopyWith<T, $Res> {
  factory _$$InvalidCodeCopyWith(
          _$InvalidCode<T> value, $Res Function(_$InvalidCode<T>) then) =
      __$$InvalidCodeCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InvalidCodeCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$InvalidCode<T>>
    implements _$$InvalidCodeCopyWith<T, $Res> {
  __$$InvalidCodeCopyWithImpl(
      _$InvalidCode<T> _value, $Res Function(_$InvalidCode<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InvalidCode<T> implements InvalidCode<T> {
  const _$InvalidCode();

  @override
  String toString() {
    return 'AuthFailure<$T>.invalidCode()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvalidCode<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return invalidCode();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return invalidCode?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidCode != null) {
      return invalidCode();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return invalidCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return invalidCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (invalidCode != null) {
      return invalidCode(this);
    }
    return orElse();
  }
}

abstract class InvalidCode<T> implements AuthFailure<T> {
  const factory InvalidCode() = _$InvalidCode<T>;
}

/// @nodoc
abstract class _$$EmailNotFoundCopyWith<T, $Res> {
  factory _$$EmailNotFoundCopyWith(
          _$EmailNotFound<T> value, $Res Function(_$EmailNotFound<T>) then) =
      __$$EmailNotFoundCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$EmailNotFoundCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$EmailNotFound<T>>
    implements _$$EmailNotFoundCopyWith<T, $Res> {
  __$$EmailNotFoundCopyWithImpl(
      _$EmailNotFound<T> _value, $Res Function(_$EmailNotFound<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EmailNotFound<T> implements EmailNotFound<T> {
  const _$EmailNotFound();

  @override
  String toString() {
    return 'AuthFailure<$T>.emailNotFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmailNotFound<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return emailNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return emailNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (emailNotFound != null) {
      return emailNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return emailNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return emailNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (emailNotFound != null) {
      return emailNotFound(this);
    }
    return orElse();
  }
}

abstract class EmailNotFound<T> implements AuthFailure<T> {
  const factory EmailNotFound() = _$EmailNotFound<T>;
}

/// @nodoc
abstract class _$$LimitExceededExceptionCopyWith<T, $Res> {
  factory _$$LimitExceededExceptionCopyWith(_$LimitExceededException<T> value,
          $Res Function(_$LimitExceededException<T>) then) =
      __$$LimitExceededExceptionCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LimitExceededExceptionCopyWithImpl<T, $Res>
    extends _$AuthFailureCopyWithImpl<T, $Res, _$LimitExceededException<T>>
    implements _$$LimitExceededExceptionCopyWith<T, $Res> {
  __$$LimitExceededExceptionCopyWithImpl(_$LimitExceededException<T> _value,
      $Res Function(_$LimitExceededException<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LimitExceededException<T> implements LimitExceededException<T> {
  const _$LimitExceededException();

  @override
  String toString() {
    return 'AuthFailure<$T>.limitExceededException()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LimitExceededException<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() cancelByUser,
    required TResult Function() serverError,
    required TResult Function() emailAlreadyUsed,
    required TResult Function() invalidEmailPassword,
    required TResult Function() invalidEmail,
    required TResult Function() invalidPassword,
    required TResult Function() invalidCode,
    required TResult Function() emailNotFound,
    required TResult Function() limitExceededException,
  }) {
    return limitExceededException();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? cancelByUser,
    TResult? Function()? serverError,
    TResult? Function()? emailAlreadyUsed,
    TResult? Function()? invalidEmailPassword,
    TResult? Function()? invalidEmail,
    TResult? Function()? invalidPassword,
    TResult? Function()? invalidCode,
    TResult? Function()? emailNotFound,
    TResult? Function()? limitExceededException,
  }) {
    return limitExceededException?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? cancelByUser,
    TResult Function()? serverError,
    TResult Function()? emailAlreadyUsed,
    TResult Function()? invalidEmailPassword,
    TResult Function()? invalidEmail,
    TResult Function()? invalidPassword,
    TResult Function()? invalidCode,
    TResult Function()? emailNotFound,
    TResult Function()? limitExceededException,
    required TResult orElse(),
  }) {
    if (limitExceededException != null) {
      return limitExceededException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CancelByUser<T> value) cancelByUser,
    required TResult Function(AuthServerError<T> value) serverError,
    required TResult Function(EmailAlreadyUsed<T> value) emailAlreadyUsed,
    required TResult Function(InvalidEmailPassword<T> value)
        invalidEmailPassword,
    required TResult Function(InvalidEmail<T> value) invalidEmail,
    required TResult Function(InvalidPassword<T> value) invalidPassword,
    required TResult Function(InvalidCode<T> value) invalidCode,
    required TResult Function(EmailNotFound<T> value) emailNotFound,
    required TResult Function(LimitExceededException<T> value)
        limitExceededException,
  }) {
    return limitExceededException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CancelByUser<T> value)? cancelByUser,
    TResult? Function(AuthServerError<T> value)? serverError,
    TResult? Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult? Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult? Function(InvalidEmail<T> value)? invalidEmail,
    TResult? Function(InvalidPassword<T> value)? invalidPassword,
    TResult? Function(InvalidCode<T> value)? invalidCode,
    TResult? Function(EmailNotFound<T> value)? emailNotFound,
    TResult? Function(LimitExceededException<T> value)? limitExceededException,
  }) {
    return limitExceededException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CancelByUser<T> value)? cancelByUser,
    TResult Function(AuthServerError<T> value)? serverError,
    TResult Function(EmailAlreadyUsed<T> value)? emailAlreadyUsed,
    TResult Function(InvalidEmailPassword<T> value)? invalidEmailPassword,
    TResult Function(InvalidEmail<T> value)? invalidEmail,
    TResult Function(InvalidPassword<T> value)? invalidPassword,
    TResult Function(InvalidCode<T> value)? invalidCode,
    TResult Function(EmailNotFound<T> value)? emailNotFound,
    TResult Function(LimitExceededException<T> value)? limitExceededException,
    required TResult orElse(),
  }) {
    if (limitExceededException != null) {
      return limitExceededException(this);
    }
    return orElse();
  }
}

abstract class LimitExceededException<T> implements AuthFailure<T> {
  const factory LimitExceededException() = _$LimitExceededException<T>;
}
