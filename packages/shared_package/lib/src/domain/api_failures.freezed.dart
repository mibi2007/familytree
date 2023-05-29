// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiFailure<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiFailureCopyWith<T, $Res> {
  factory $ApiFailureCopyWith(
          ApiFailure<T> value, $Res Function(ApiFailure<T>) then) =
      _$ApiFailureCopyWithImpl<T, $Res, ApiFailure<T>>;
}

/// @nodoc
class _$ApiFailureCopyWithImpl<T, $Res, $Val extends ApiFailure<T>>
    implements $ApiFailureCopyWith<T, $Res> {
  _$ApiFailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ClientErrorCopyWith<T, $Res> {
  factory _$$ClientErrorCopyWith(
          _$ClientError<T> value, $Res Function(_$ClientError<T>) then) =
      __$$ClientErrorCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ClientErrorCopyWithImpl<T, $Res>
    extends _$ApiFailureCopyWithImpl<T, $Res, _$ClientError<T>>
    implements _$$ClientErrorCopyWith<T, $Res> {
  __$$ClientErrorCopyWithImpl(
      _$ClientError<T> _value, $Res Function(_$ClientError<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClientError<T> implements ClientError<T> {
  const _$ClientError();

  @override
  String toString() {
    return 'ApiFailure<$T>.clientError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClientError<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) {
    return clientError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) {
    return clientError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (clientError != null) {
      return clientError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) {
    return clientError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) {
    return clientError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (clientError != null) {
      return clientError(this);
    }
    return orElse();
  }
}

abstract class ClientError<T> implements ApiFailure<T> {
  const factory ClientError() = _$ClientError<T>;
}

/// @nodoc
abstract class _$$ApiServerErrorCopyWith<T, $Res> {
  factory _$$ApiServerErrorCopyWith(
          _$ApiServerError<T> value, $Res Function(_$ApiServerError<T>) then) =
      __$$ApiServerErrorCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$ApiServerErrorCopyWithImpl<T, $Res>
    extends _$ApiFailureCopyWithImpl<T, $Res, _$ApiServerError<T>>
    implements _$$ApiServerErrorCopyWith<T, $Res> {
  __$$ApiServerErrorCopyWithImpl(
      _$ApiServerError<T> _value, $Res Function(_$ApiServerError<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ApiServerError<T> implements ApiServerError<T> {
  const _$ApiServerError();

  @override
  String toString() {
    return 'ApiFailure<$T>.serverError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ApiServerError<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) {
    return serverError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) {
    return serverError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
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
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ApiServerError<T> implements ApiFailure<T> {
  const factory ApiServerError() = _$ApiServerError<T>;
}

/// @nodoc
abstract class _$$UnAuthenticatedCopyWith<T, $Res> {
  factory _$$UnAuthenticatedCopyWith(_$UnAuthenticated<T> value,
          $Res Function(_$UnAuthenticated<T>) then) =
      __$$UnAuthenticatedCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UnAuthenticatedCopyWithImpl<T, $Res>
    extends _$ApiFailureCopyWithImpl<T, $Res, _$UnAuthenticated<T>>
    implements _$$UnAuthenticatedCopyWith<T, $Res> {
  __$$UnAuthenticatedCopyWithImpl(
      _$UnAuthenticated<T> _value, $Res Function(_$UnAuthenticated<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnAuthenticated<T> implements UnAuthenticated<T> {
  const _$UnAuthenticated();

  @override
  String toString() {
    return 'ApiFailure<$T>.unAuthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnAuthenticated<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) {
    return unAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) {
    return unAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class UnAuthenticated<T> implements ApiFailure<T> {
  const factory UnAuthenticated() = _$UnAuthenticated<T>;
}

/// @nodoc
abstract class _$$SubscriptionExpiredCopyWith<T, $Res> {
  factory _$$SubscriptionExpiredCopyWith(_$SubscriptionExpired<T> value,
          $Res Function(_$SubscriptionExpired<T>) then) =
      __$$SubscriptionExpiredCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$SubscriptionExpiredCopyWithImpl<T, $Res>
    extends _$ApiFailureCopyWithImpl<T, $Res, _$SubscriptionExpired<T>>
    implements _$$SubscriptionExpiredCopyWith<T, $Res> {
  __$$SubscriptionExpiredCopyWithImpl(_$SubscriptionExpired<T> _value,
      $Res Function(_$SubscriptionExpired<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubscriptionExpired<T> implements SubscriptionExpired<T> {
  const _$SubscriptionExpired();

  @override
  String toString() {
    return 'ApiFailure<$T>.subscriptionExpired()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubscriptionExpired<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) {
    return subscriptionExpired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) {
    return subscriptionExpired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (subscriptionExpired != null) {
      return subscriptionExpired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) {
    return subscriptionExpired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) {
    return subscriptionExpired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (subscriptionExpired != null) {
      return subscriptionExpired(this);
    }
    return orElse();
  }
}

abstract class SubscriptionExpired<T> implements ApiFailure<T> {
  const factory SubscriptionExpired() = _$SubscriptionExpired<T>;
}

/// @nodoc
abstract class _$$RunOutMockTestCopyWith<T, $Res> {
  factory _$$RunOutMockTestCopyWith(
          _$RunOutMockTest<T> value, $Res Function(_$RunOutMockTest<T>) then) =
      __$$RunOutMockTestCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$RunOutMockTestCopyWithImpl<T, $Res>
    extends _$ApiFailureCopyWithImpl<T, $Res, _$RunOutMockTest<T>>
    implements _$$RunOutMockTestCopyWith<T, $Res> {
  __$$RunOutMockTestCopyWithImpl(
      _$RunOutMockTest<T> _value, $Res Function(_$RunOutMockTest<T>) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RunOutMockTest<T> implements RunOutMockTest<T> {
  const _$RunOutMockTest();

  @override
  String toString() {
    return 'ApiFailure<$T>.ranOutMockTest()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RunOutMockTest<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientError,
    required TResult Function() serverError,
    required TResult Function() unAuthenticated,
    required TResult Function() subscriptionExpired,
    required TResult Function() ranOutMockTest,
  }) {
    return ranOutMockTest();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? clientError,
    TResult? Function()? serverError,
    TResult? Function()? unAuthenticated,
    TResult? Function()? subscriptionExpired,
    TResult? Function()? ranOutMockTest,
  }) {
    return ranOutMockTest?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientError,
    TResult Function()? serverError,
    TResult Function()? unAuthenticated,
    TResult Function()? subscriptionExpired,
    TResult Function()? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (ranOutMockTest != null) {
      return ranOutMockTest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClientError<T> value) clientError,
    required TResult Function(ApiServerError<T> value) serverError,
    required TResult Function(UnAuthenticated<T> value) unAuthenticated,
    required TResult Function(SubscriptionExpired<T> value) subscriptionExpired,
    required TResult Function(RunOutMockTest<T> value) ranOutMockTest,
  }) {
    return ranOutMockTest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClientError<T> value)? clientError,
    TResult? Function(ApiServerError<T> value)? serverError,
    TResult? Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult? Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult? Function(RunOutMockTest<T> value)? ranOutMockTest,
  }) {
    return ranOutMockTest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClientError<T> value)? clientError,
    TResult Function(ApiServerError<T> value)? serverError,
    TResult Function(UnAuthenticated<T> value)? unAuthenticated,
    TResult Function(SubscriptionExpired<T> value)? subscriptionExpired,
    TResult Function(RunOutMockTest<T> value)? ranOutMockTest,
    required TResult orElse(),
  }) {
    if (ranOutMockTest != null) {
      return ranOutMockTest(this);
    }
    return orElse();
  }
}

abstract class RunOutMockTest<T> implements ApiFailure<T> {
  const factory RunOutMockTest() = _$RunOutMockTest<T>;
}
