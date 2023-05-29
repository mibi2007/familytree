// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Initial with DiagnosticableTreeMixin implements Initial {
  const _$Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements AuthState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class _$$LoadingCopyWith<$Res> {
  factory _$$LoadingCopyWith(_$Loading value, $Res Function(_$Loading) then) =
      __$$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$Loading>
    implements _$$LoadingCopyWith<$Res> {
  __$$LoadingCopyWithImpl(_$Loading _value, $Res Function(_$Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Loading with DiagnosticableTreeMixin implements Loading {
  const _$Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements AuthState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class _$$AuthenticatedHasAccessCopyWith<$Res> {
  factory _$$AuthenticatedHasAccessCopyWith(_$AuthenticatedHasAccess value,
          $Res Function(_$AuthenticatedHasAccess) then) =
      __$$AuthenticatedHasAccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedHasAccessCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedHasAccess>
    implements _$$AuthenticatedHasAccessCopyWith<$Res> {
  __$$AuthenticatedHasAccessCopyWithImpl(_$AuthenticatedHasAccess _value,
      $Res Function(_$AuthenticatedHasAccess) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatedHasAccess
    with DiagnosticableTreeMixin
    implements AuthenticatedHasAccess {
  const _$AuthenticatedHasAccess();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticatedHasAccess()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'AuthState.authenticatedHasAccess'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedHasAccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) {
    return authenticatedHasAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) {
    return authenticatedHasAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticatedHasAccess != null) {
      return authenticatedHasAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return authenticatedHasAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return authenticatedHasAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticatedHasAccess != null) {
      return authenticatedHasAccess(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedHasAccess implements AuthState {
  const factory AuthenticatedHasAccess() = _$AuthenticatedHasAccess;
}

/// @nodoc
abstract class _$$AuthenticatedNoAccessCopyWith<$Res> {
  factory _$$AuthenticatedNoAccessCopyWith(_$AuthenticatedNoAccess value,
          $Res Function(_$AuthenticatedNoAccess) then) =
      __$$AuthenticatedNoAccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticatedNoAccessCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedNoAccess>
    implements _$$AuthenticatedNoAccessCopyWith<$Res> {
  __$$AuthenticatedNoAccessCopyWithImpl(_$AuthenticatedNoAccess _value,
      $Res Function(_$AuthenticatedNoAccess) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticatedNoAccess
    with DiagnosticableTreeMixin
    implements AuthenticatedNoAccess {
  const _$AuthenticatedNoAccess();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticatedNoAccess()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'AuthState.authenticatedNoAccess'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthenticatedNoAccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) {
    return authenticatedNoAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) {
    return authenticatedNoAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticatedNoAccess != null) {
      return authenticatedNoAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return authenticatedNoAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return authenticatedNoAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (authenticatedNoAccess != null) {
      return authenticatedNoAccess(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedNoAccess implements AuthState {
  const factory AuthenticatedNoAccess() = _$AuthenticatedNoAccess;
}

/// @nodoc
abstract class _$$UnAuthenticatedCopyWith<$Res> {
  factory _$$UnAuthenticatedCopyWith(
          _$UnAuthenticated value, $Res Function(_$UnAuthenticated) then) =
      __$$UnAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnAuthenticated>
    implements _$$UnAuthenticatedCopyWith<$Res> {
  __$$UnAuthenticatedCopyWithImpl(
      _$UnAuthenticated _value, $Res Function(_$UnAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UnAuthenticated
    with DiagnosticableTreeMixin
    implements UnAuthenticated {
  const _$UnAuthenticated();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.unAuthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AuthState.unAuthenticated'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() authenticatedHasAccess,
    required TResult Function() authenticatedNoAccess,
    required TResult Function() unAuthenticated,
  }) {
    return unAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? authenticatedHasAccess,
    TResult? Function()? authenticatedNoAccess,
    TResult? Function()? unAuthenticated,
  }) {
    return unAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? authenticatedHasAccess,
    TResult Function()? authenticatedNoAccess,
    TResult Function()? unAuthenticated,
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
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(AuthenticatedHasAccess value)
        authenticatedHasAccess,
    required TResult Function(AuthenticatedNoAccess value)
        authenticatedNoAccess,
    required TResult Function(UnAuthenticated value) unAuthenticated,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult? Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult? Function(UnAuthenticated value)? unAuthenticated,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(AuthenticatedHasAccess value)? authenticatedHasAccess,
    TResult Function(AuthenticatedNoAccess value)? authenticatedNoAccess,
    TResult Function(UnAuthenticated value)? unAuthenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class UnAuthenticated implements AuthState {
  const factory UnAuthenticated() = _$UnAuthenticated;
}
