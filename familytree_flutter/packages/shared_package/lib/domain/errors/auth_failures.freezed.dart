// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>()';
}


}

/// @nodoc
class $AuthFailureCopyWith<T,$Res>  {
$AuthFailureCopyWith(AuthFailure<T> _, $Res Function(AuthFailure<T>) __);
}


/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns<T> on AuthFailure<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CancelByUser<T> value)?  cancelByUser,TResult Function( AuthServerError<T> value)?  serverError,TResult Function( EmailAlreadyUsed<T> value)?  emailAlreadyUsed,TResult Function( IdAlreadyUsed<T> value)?  idAlreadyUsed,TResult Function( InvalidEmailPassword<T> value)?  invalidEmailPassword,TResult Function( InvalidEmail<T> value)?  invalidEmail,TResult Function( InvalidPhone<T> value)?  invalidPhone,TResult Function( InvalidPassword<T> value)?  invalidPassword,TResult Function( InvalidCode<T> value)?  invalidCode,TResult Function( UserNotFound<T> value)?  userNotFound,TResult Function( LimitExceededException<T> value)?  limitExceededException,TResult Function( InvalidParam<T> value)?  invalidParam,TResult Function( CustomTokenMismatch<T> value)?  customTokenMismatch,TResult Function( InvalidCustomToken<T> value)?  invalidCustomToken,TResult Function( EmailAlreadyConfirmed<T> value)?  emailAlreadyConfirmed,TResult Function( MissingEmail<T> value)?  missingEmail,TResult Function( InvalidToken<T> value)?  invalidToken,TResult Function( ExpiredToken<T> value)?  expiredToken,TResult Function( AccountExistsWithDifferentCredential<T> value)?  accountExistsWithDifferentCredential,TResult Function( PluginNotInitialized<T> value)?  pluginNotInitialized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CancelByUser() when cancelByUser != null:
return cancelByUser(_that);case AuthServerError() when serverError != null:
return serverError(_that);case EmailAlreadyUsed() when emailAlreadyUsed != null:
return emailAlreadyUsed(_that);case IdAlreadyUsed() when idAlreadyUsed != null:
return idAlreadyUsed(_that);case InvalidEmailPassword() when invalidEmailPassword != null:
return invalidEmailPassword(_that);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case InvalidPhone() when invalidPhone != null:
return invalidPhone(_that);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that);case InvalidCode() when invalidCode != null:
return invalidCode(_that);case UserNotFound() when userNotFound != null:
return userNotFound(_that);case LimitExceededException() when limitExceededException != null:
return limitExceededException(_that);case InvalidParam() when invalidParam != null:
return invalidParam(_that);case CustomTokenMismatch() when customTokenMismatch != null:
return customTokenMismatch(_that);case InvalidCustomToken() when invalidCustomToken != null:
return invalidCustomToken(_that);case EmailAlreadyConfirmed() when emailAlreadyConfirmed != null:
return emailAlreadyConfirmed(_that);case MissingEmail() when missingEmail != null:
return missingEmail(_that);case InvalidToken() when invalidToken != null:
return invalidToken(_that);case ExpiredToken() when expiredToken != null:
return expiredToken(_that);case AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that);case PluginNotInitialized() when pluginNotInitialized != null:
return pluginNotInitialized(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CancelByUser<T> value)  cancelByUser,required TResult Function( AuthServerError<T> value)  serverError,required TResult Function( EmailAlreadyUsed<T> value)  emailAlreadyUsed,required TResult Function( IdAlreadyUsed<T> value)  idAlreadyUsed,required TResult Function( InvalidEmailPassword<T> value)  invalidEmailPassword,required TResult Function( InvalidEmail<T> value)  invalidEmail,required TResult Function( InvalidPhone<T> value)  invalidPhone,required TResult Function( InvalidPassword<T> value)  invalidPassword,required TResult Function( InvalidCode<T> value)  invalidCode,required TResult Function( UserNotFound<T> value)  userNotFound,required TResult Function( LimitExceededException<T> value)  limitExceededException,required TResult Function( InvalidParam<T> value)  invalidParam,required TResult Function( CustomTokenMismatch<T> value)  customTokenMismatch,required TResult Function( InvalidCustomToken<T> value)  invalidCustomToken,required TResult Function( EmailAlreadyConfirmed<T> value)  emailAlreadyConfirmed,required TResult Function( MissingEmail<T> value)  missingEmail,required TResult Function( InvalidToken<T> value)  invalidToken,required TResult Function( ExpiredToken<T> value)  expiredToken,required TResult Function( AccountExistsWithDifferentCredential<T> value)  accountExistsWithDifferentCredential,required TResult Function( PluginNotInitialized<T> value)  pluginNotInitialized,}){
final _that = this;
switch (_that) {
case CancelByUser():
return cancelByUser(_that);case AuthServerError():
return serverError(_that);case EmailAlreadyUsed():
return emailAlreadyUsed(_that);case IdAlreadyUsed():
return idAlreadyUsed(_that);case InvalidEmailPassword():
return invalidEmailPassword(_that);case InvalidEmail():
return invalidEmail(_that);case InvalidPhone():
return invalidPhone(_that);case InvalidPassword():
return invalidPassword(_that);case InvalidCode():
return invalidCode(_that);case UserNotFound():
return userNotFound(_that);case LimitExceededException():
return limitExceededException(_that);case InvalidParam():
return invalidParam(_that);case CustomTokenMismatch():
return customTokenMismatch(_that);case InvalidCustomToken():
return invalidCustomToken(_that);case EmailAlreadyConfirmed():
return emailAlreadyConfirmed(_that);case MissingEmail():
return missingEmail(_that);case InvalidToken():
return invalidToken(_that);case ExpiredToken():
return expiredToken(_that);case AccountExistsWithDifferentCredential():
return accountExistsWithDifferentCredential(_that);case PluginNotInitialized():
return pluginNotInitialized(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CancelByUser<T> value)?  cancelByUser,TResult? Function( AuthServerError<T> value)?  serverError,TResult? Function( EmailAlreadyUsed<T> value)?  emailAlreadyUsed,TResult? Function( IdAlreadyUsed<T> value)?  idAlreadyUsed,TResult? Function( InvalidEmailPassword<T> value)?  invalidEmailPassword,TResult? Function( InvalidEmail<T> value)?  invalidEmail,TResult? Function( InvalidPhone<T> value)?  invalidPhone,TResult? Function( InvalidPassword<T> value)?  invalidPassword,TResult? Function( InvalidCode<T> value)?  invalidCode,TResult? Function( UserNotFound<T> value)?  userNotFound,TResult? Function( LimitExceededException<T> value)?  limitExceededException,TResult? Function( InvalidParam<T> value)?  invalidParam,TResult? Function( CustomTokenMismatch<T> value)?  customTokenMismatch,TResult? Function( InvalidCustomToken<T> value)?  invalidCustomToken,TResult? Function( EmailAlreadyConfirmed<T> value)?  emailAlreadyConfirmed,TResult? Function( MissingEmail<T> value)?  missingEmail,TResult? Function( InvalidToken<T> value)?  invalidToken,TResult? Function( ExpiredToken<T> value)?  expiredToken,TResult? Function( AccountExistsWithDifferentCredential<T> value)?  accountExistsWithDifferentCredential,TResult? Function( PluginNotInitialized<T> value)?  pluginNotInitialized,}){
final _that = this;
switch (_that) {
case CancelByUser() when cancelByUser != null:
return cancelByUser(_that);case AuthServerError() when serverError != null:
return serverError(_that);case EmailAlreadyUsed() when emailAlreadyUsed != null:
return emailAlreadyUsed(_that);case IdAlreadyUsed() when idAlreadyUsed != null:
return idAlreadyUsed(_that);case InvalidEmailPassword() when invalidEmailPassword != null:
return invalidEmailPassword(_that);case InvalidEmail() when invalidEmail != null:
return invalidEmail(_that);case InvalidPhone() when invalidPhone != null:
return invalidPhone(_that);case InvalidPassword() when invalidPassword != null:
return invalidPassword(_that);case InvalidCode() when invalidCode != null:
return invalidCode(_that);case UserNotFound() when userNotFound != null:
return userNotFound(_that);case LimitExceededException() when limitExceededException != null:
return limitExceededException(_that);case InvalidParam() when invalidParam != null:
return invalidParam(_that);case CustomTokenMismatch() when customTokenMismatch != null:
return customTokenMismatch(_that);case InvalidCustomToken() when invalidCustomToken != null:
return invalidCustomToken(_that);case EmailAlreadyConfirmed() when emailAlreadyConfirmed != null:
return emailAlreadyConfirmed(_that);case MissingEmail() when missingEmail != null:
return missingEmail(_that);case InvalidToken() when invalidToken != null:
return invalidToken(_that);case ExpiredToken() when expiredToken != null:
return expiredToken(_that);case AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that);case PluginNotInitialized() when pluginNotInitialized != null:
return pluginNotInitialized(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  cancelByUser,TResult Function()?  serverError,TResult Function()?  emailAlreadyUsed,TResult Function()?  idAlreadyUsed,TResult Function()?  invalidEmailPassword,TResult Function()?  invalidEmail,TResult Function()?  invalidPhone,TResult Function()?  invalidPassword,TResult Function()?  invalidCode,TResult Function()?  userNotFound,TResult Function()?  limitExceededException,TResult Function( String param)?  invalidParam,TResult Function( String param)?  customTokenMismatch,TResult Function( String param)?  invalidCustomToken,TResult Function()?  emailAlreadyConfirmed,TResult Function()?  missingEmail,TResult Function()?  invalidToken,TResult Function()?  expiredToken,TResult Function( String email)?  accountExistsWithDifferentCredential,TResult Function( String provider)?  pluginNotInitialized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CancelByUser() when cancelByUser != null:
return cancelByUser();case AuthServerError() when serverError != null:
return serverError();case EmailAlreadyUsed() when emailAlreadyUsed != null:
return emailAlreadyUsed();case IdAlreadyUsed() when idAlreadyUsed != null:
return idAlreadyUsed();case InvalidEmailPassword() when invalidEmailPassword != null:
return invalidEmailPassword();case InvalidEmail() when invalidEmail != null:
return invalidEmail();case InvalidPhone() when invalidPhone != null:
return invalidPhone();case InvalidPassword() when invalidPassword != null:
return invalidPassword();case InvalidCode() when invalidCode != null:
return invalidCode();case UserNotFound() when userNotFound != null:
return userNotFound();case LimitExceededException() when limitExceededException != null:
return limitExceededException();case InvalidParam() when invalidParam != null:
return invalidParam(_that.param);case CustomTokenMismatch() when customTokenMismatch != null:
return customTokenMismatch(_that.param);case InvalidCustomToken() when invalidCustomToken != null:
return invalidCustomToken(_that.param);case EmailAlreadyConfirmed() when emailAlreadyConfirmed != null:
return emailAlreadyConfirmed();case MissingEmail() when missingEmail != null:
return missingEmail();case InvalidToken() when invalidToken != null:
return invalidToken();case ExpiredToken() when expiredToken != null:
return expiredToken();case AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that.email);case PluginNotInitialized() when pluginNotInitialized != null:
return pluginNotInitialized(_that.provider);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  cancelByUser,required TResult Function()  serverError,required TResult Function()  emailAlreadyUsed,required TResult Function()  idAlreadyUsed,required TResult Function()  invalidEmailPassword,required TResult Function()  invalidEmail,required TResult Function()  invalidPhone,required TResult Function()  invalidPassword,required TResult Function()  invalidCode,required TResult Function()  userNotFound,required TResult Function()  limitExceededException,required TResult Function( String param)  invalidParam,required TResult Function( String param)  customTokenMismatch,required TResult Function( String param)  invalidCustomToken,required TResult Function()  emailAlreadyConfirmed,required TResult Function()  missingEmail,required TResult Function()  invalidToken,required TResult Function()  expiredToken,required TResult Function( String email)  accountExistsWithDifferentCredential,required TResult Function( String provider)  pluginNotInitialized,}) {final _that = this;
switch (_that) {
case CancelByUser():
return cancelByUser();case AuthServerError():
return serverError();case EmailAlreadyUsed():
return emailAlreadyUsed();case IdAlreadyUsed():
return idAlreadyUsed();case InvalidEmailPassword():
return invalidEmailPassword();case InvalidEmail():
return invalidEmail();case InvalidPhone():
return invalidPhone();case InvalidPassword():
return invalidPassword();case InvalidCode():
return invalidCode();case UserNotFound():
return userNotFound();case LimitExceededException():
return limitExceededException();case InvalidParam():
return invalidParam(_that.param);case CustomTokenMismatch():
return customTokenMismatch(_that.param);case InvalidCustomToken():
return invalidCustomToken(_that.param);case EmailAlreadyConfirmed():
return emailAlreadyConfirmed();case MissingEmail():
return missingEmail();case InvalidToken():
return invalidToken();case ExpiredToken():
return expiredToken();case AccountExistsWithDifferentCredential():
return accountExistsWithDifferentCredential(_that.email);case PluginNotInitialized():
return pluginNotInitialized(_that.provider);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  cancelByUser,TResult? Function()?  serverError,TResult? Function()?  emailAlreadyUsed,TResult? Function()?  idAlreadyUsed,TResult? Function()?  invalidEmailPassword,TResult? Function()?  invalidEmail,TResult? Function()?  invalidPhone,TResult? Function()?  invalidPassword,TResult? Function()?  invalidCode,TResult? Function()?  userNotFound,TResult? Function()?  limitExceededException,TResult? Function( String param)?  invalidParam,TResult? Function( String param)?  customTokenMismatch,TResult? Function( String param)?  invalidCustomToken,TResult? Function()?  emailAlreadyConfirmed,TResult? Function()?  missingEmail,TResult? Function()?  invalidToken,TResult? Function()?  expiredToken,TResult? Function( String email)?  accountExistsWithDifferentCredential,TResult? Function( String provider)?  pluginNotInitialized,}) {final _that = this;
switch (_that) {
case CancelByUser() when cancelByUser != null:
return cancelByUser();case AuthServerError() when serverError != null:
return serverError();case EmailAlreadyUsed() when emailAlreadyUsed != null:
return emailAlreadyUsed();case IdAlreadyUsed() when idAlreadyUsed != null:
return idAlreadyUsed();case InvalidEmailPassword() when invalidEmailPassword != null:
return invalidEmailPassword();case InvalidEmail() when invalidEmail != null:
return invalidEmail();case InvalidPhone() when invalidPhone != null:
return invalidPhone();case InvalidPassword() when invalidPassword != null:
return invalidPassword();case InvalidCode() when invalidCode != null:
return invalidCode();case UserNotFound() when userNotFound != null:
return userNotFound();case LimitExceededException() when limitExceededException != null:
return limitExceededException();case InvalidParam() when invalidParam != null:
return invalidParam(_that.param);case CustomTokenMismatch() when customTokenMismatch != null:
return customTokenMismatch(_that.param);case InvalidCustomToken() when invalidCustomToken != null:
return invalidCustomToken(_that.param);case EmailAlreadyConfirmed() when emailAlreadyConfirmed != null:
return emailAlreadyConfirmed();case MissingEmail() when missingEmail != null:
return missingEmail();case InvalidToken() when invalidToken != null:
return invalidToken();case ExpiredToken() when expiredToken != null:
return expiredToken();case AccountExistsWithDifferentCredential() when accountExistsWithDifferentCredential != null:
return accountExistsWithDifferentCredential(_that.email);case PluginNotInitialized() when pluginNotInitialized != null:
return pluginNotInitialized(_that.provider);case _:
  return null;

}
}

}

/// @nodoc


class CancelByUser<T> implements AuthFailure<T> {
  const CancelByUser();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelByUser<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.cancelByUser()';
}


}




/// @nodoc


class AuthServerError<T> implements AuthFailure<T> {
  const AuthServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthServerError<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.serverError()';
}


}




/// @nodoc


class EmailAlreadyUsed<T> implements AuthFailure<T> {
  const EmailAlreadyUsed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyUsed<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.emailAlreadyUsed()';
}


}




/// @nodoc


class IdAlreadyUsed<T> implements AuthFailure<T> {
  const IdAlreadyUsed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdAlreadyUsed<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.idAlreadyUsed()';
}


}




/// @nodoc


class InvalidEmailPassword<T> implements AuthFailure<T> {
  const InvalidEmailPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmailPassword<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidEmailPassword()';
}


}




/// @nodoc


class InvalidEmail<T> implements AuthFailure<T> {
  const InvalidEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidEmail<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidEmail()';
}


}




/// @nodoc


class InvalidPhone<T> implements AuthFailure<T> {
  const InvalidPhone();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidPhone<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidPhone()';
}


}




/// @nodoc


class InvalidPassword<T> implements AuthFailure<T> {
  const InvalidPassword();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidPassword<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidPassword()';
}


}




/// @nodoc


class InvalidCode<T> implements AuthFailure<T> {
  const InvalidCode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCode<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidCode()';
}


}




/// @nodoc


class UserNotFound<T> implements AuthFailure<T> {
  const UserNotFound();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserNotFound<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.userNotFound()';
}


}




/// @nodoc


class LimitExceededException<T> implements AuthFailure<T> {
  const LimitExceededException();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LimitExceededException<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.limitExceededException()';
}


}




/// @nodoc


class InvalidParam<T> implements AuthFailure<T> {
  const InvalidParam(this.param);
  

 final  String param;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidParamCopyWith<T, InvalidParam<T>> get copyWith => _$InvalidParamCopyWithImpl<T, InvalidParam<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidParam<T>&&(identical(other.param, param) || other.param == param));
}


@override
int get hashCode => Object.hash(runtimeType,param);

@override
String toString() {
  return 'AuthFailure<$T>.invalidParam(param: $param)';
}


}

/// @nodoc
abstract mixin class $InvalidParamCopyWith<T,$Res> implements $AuthFailureCopyWith<T, $Res> {
  factory $InvalidParamCopyWith(InvalidParam<T> value, $Res Function(InvalidParam<T>) _then) = _$InvalidParamCopyWithImpl;
@useResult
$Res call({
 String param
});




}
/// @nodoc
class _$InvalidParamCopyWithImpl<T,$Res>
    implements $InvalidParamCopyWith<T, $Res> {
  _$InvalidParamCopyWithImpl(this._self, this._then);

  final InvalidParam<T> _self;
  final $Res Function(InvalidParam<T>) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? param = null,}) {
  return _then(InvalidParam<T>(
null == param ? _self.param : param // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CustomTokenMismatch<T> implements AuthFailure<T> {
  const CustomTokenMismatch(this.param);
  

 final  String param;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomTokenMismatchCopyWith<T, CustomTokenMismatch<T>> get copyWith => _$CustomTokenMismatchCopyWithImpl<T, CustomTokenMismatch<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomTokenMismatch<T>&&(identical(other.param, param) || other.param == param));
}


@override
int get hashCode => Object.hash(runtimeType,param);

@override
String toString() {
  return 'AuthFailure<$T>.customTokenMismatch(param: $param)';
}


}

/// @nodoc
abstract mixin class $CustomTokenMismatchCopyWith<T,$Res> implements $AuthFailureCopyWith<T, $Res> {
  factory $CustomTokenMismatchCopyWith(CustomTokenMismatch<T> value, $Res Function(CustomTokenMismatch<T>) _then) = _$CustomTokenMismatchCopyWithImpl;
@useResult
$Res call({
 String param
});




}
/// @nodoc
class _$CustomTokenMismatchCopyWithImpl<T,$Res>
    implements $CustomTokenMismatchCopyWith<T, $Res> {
  _$CustomTokenMismatchCopyWithImpl(this._self, this._then);

  final CustomTokenMismatch<T> _self;
  final $Res Function(CustomTokenMismatch<T>) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? param = null,}) {
  return _then(CustomTokenMismatch<T>(
null == param ? _self.param : param // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class InvalidCustomToken<T> implements AuthFailure<T> {
  const InvalidCustomToken(this.param);
  

 final  String param;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvalidCustomTokenCopyWith<T, InvalidCustomToken<T>> get copyWith => _$InvalidCustomTokenCopyWithImpl<T, InvalidCustomToken<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCustomToken<T>&&(identical(other.param, param) || other.param == param));
}


@override
int get hashCode => Object.hash(runtimeType,param);

@override
String toString() {
  return 'AuthFailure<$T>.invalidCustomToken(param: $param)';
}


}

/// @nodoc
abstract mixin class $InvalidCustomTokenCopyWith<T,$Res> implements $AuthFailureCopyWith<T, $Res> {
  factory $InvalidCustomTokenCopyWith(InvalidCustomToken<T> value, $Res Function(InvalidCustomToken<T>) _then) = _$InvalidCustomTokenCopyWithImpl;
@useResult
$Res call({
 String param
});




}
/// @nodoc
class _$InvalidCustomTokenCopyWithImpl<T,$Res>
    implements $InvalidCustomTokenCopyWith<T, $Res> {
  _$InvalidCustomTokenCopyWithImpl(this._self, this._then);

  final InvalidCustomToken<T> _self;
  final $Res Function(InvalidCustomToken<T>) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? param = null,}) {
  return _then(InvalidCustomToken<T>(
null == param ? _self.param : param // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EmailAlreadyConfirmed<T> implements AuthFailure<T> {
  const EmailAlreadyConfirmed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyConfirmed<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.emailAlreadyConfirmed()';
}


}




/// @nodoc


class MissingEmail<T> implements AuthFailure<T> {
  const MissingEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissingEmail<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.missingEmail()';
}


}




/// @nodoc


class InvalidToken<T> implements AuthFailure<T> {
  const InvalidToken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidToken<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.invalidToken()';
}


}




/// @nodoc


class ExpiredToken<T> implements AuthFailure<T> {
  const ExpiredToken();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpiredToken<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthFailure<$T>.expiredToken()';
}


}




/// @nodoc


class AccountExistsWithDifferentCredential<T> implements AuthFailure<T> {
  const AccountExistsWithDifferentCredential(this.email);
  

 final  String email;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountExistsWithDifferentCredentialCopyWith<T, AccountExistsWithDifferentCredential<T>> get copyWith => _$AccountExistsWithDifferentCredentialCopyWithImpl<T, AccountExistsWithDifferentCredential<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountExistsWithDifferentCredential<T>&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthFailure<$T>.accountExistsWithDifferentCredential(email: $email)';
}


}

/// @nodoc
abstract mixin class $AccountExistsWithDifferentCredentialCopyWith<T,$Res> implements $AuthFailureCopyWith<T, $Res> {
  factory $AccountExistsWithDifferentCredentialCopyWith(AccountExistsWithDifferentCredential<T> value, $Res Function(AccountExistsWithDifferentCredential<T>) _then) = _$AccountExistsWithDifferentCredentialCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AccountExistsWithDifferentCredentialCopyWithImpl<T,$Res>
    implements $AccountExistsWithDifferentCredentialCopyWith<T, $Res> {
  _$AccountExistsWithDifferentCredentialCopyWithImpl(this._self, this._then);

  final AccountExistsWithDifferentCredential<T> _self;
  final $Res Function(AccountExistsWithDifferentCredential<T>) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AccountExistsWithDifferentCredential<T>(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PluginNotInitialized<T> implements AuthFailure<T> {
  const PluginNotInitialized(this.provider);
  

 final  String provider;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PluginNotInitializedCopyWith<T, PluginNotInitialized<T>> get copyWith => _$PluginNotInitializedCopyWithImpl<T, PluginNotInitialized<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PluginNotInitialized<T>&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'AuthFailure<$T>.pluginNotInitialized(provider: $provider)';
}


}

/// @nodoc
abstract mixin class $PluginNotInitializedCopyWith<T,$Res> implements $AuthFailureCopyWith<T, $Res> {
  factory $PluginNotInitializedCopyWith(PluginNotInitialized<T> value, $Res Function(PluginNotInitialized<T>) _then) = _$PluginNotInitializedCopyWithImpl;
@useResult
$Res call({
 String provider
});




}
/// @nodoc
class _$PluginNotInitializedCopyWithImpl<T,$Res>
    implements $PluginNotInitializedCopyWith<T, $Res> {
  _$PluginNotInitializedCopyWithImpl(this._self, this._then);

  final PluginNotInitialized<T> _self;
  final $Res Function(PluginNotInitialized<T>) _then;

/// Create a copy of AuthFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(PluginNotInitialized<T>(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
