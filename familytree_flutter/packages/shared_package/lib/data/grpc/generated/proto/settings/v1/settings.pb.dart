// This is a generated file - do not edit.
//
// Generated from proto/settings/v1/settings.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

import 'settings.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'settings.pbenum.dart';

/// User settings message
class UserSettings extends $pb.GeneratedMessage {
  factory UserSettings({
    $core.String? userId,
    ThemeMode? themeMode,
    Language? language,
    $core.bool? emailNotificationsEnabled,
    $core.bool? pushNotificationsEnabled,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (themeMode != null) result.themeMode = themeMode;
    if (language != null) result.language = language;
    if (emailNotificationsEnabled != null)
      result.emailNotificationsEnabled = emailNotificationsEnabled;
    if (pushNotificationsEnabled != null)
      result.pushNotificationsEnabled = pushNotificationsEnabled;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  UserSettings._();

  factory UserSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aE<ThemeMode>(2, _omitFieldNames ? '' : 'themeMode',
        enumValues: ThemeMode.values)
    ..aE<Language>(3, _omitFieldNames ? '' : 'language',
        enumValues: Language.values)
    ..aOB(4, _omitFieldNames ? '' : 'emailNotificationsEnabled')
    ..aOB(5, _omitFieldNames ? '' : 'pushNotificationsEnabled')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSettings copyWith(void Function(UserSettings) updates) =>
      super.copyWith((message) => updates(message as UserSettings))
          as UserSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSettings create() => UserSettings._();
  @$core.override
  UserSettings createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UserSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSettings>(create);
  static UserSettings? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  ThemeMode get themeMode => $_getN(1);
  @$pb.TagNumber(2)
  set themeMode(ThemeMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasThemeMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearThemeMode() => $_clearField(2);

  @$pb.TagNumber(3)
  Language get language => $_getN(2);
  @$pb.TagNumber(3)
  set language(Language value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLanguage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLanguage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailNotificationsEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set emailNotificationsEnabled($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmailNotificationsEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailNotificationsEnabled() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get pushNotificationsEnabled => $_getBF(4);
  @$pb.TagNumber(5)
  set pushNotificationsEnabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPushNotificationsEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearPushNotificationsEnabled() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $1.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureUpdatedAt() => $_ensure(6);
}

/// Request/Response messages
class GetUserSettingsRequest extends $pb.GeneratedMessage {
  factory GetUserSettingsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserSettingsRequest._();

  factory GetUserSettingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserSettingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserSettingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserSettingsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserSettingsRequest copyWith(
          void Function(GetUserSettingsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserSettingsRequest))
          as GetUserSettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserSettingsRequest create() => GetUserSettingsRequest._();
  @$core.override
  GetUserSettingsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserSettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserSettingsRequest>(create);
  static GetUserSettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetUserSettingsResponse extends $pb.GeneratedMessage {
  factory GetUserSettingsResponse({
    UserSettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  GetUserSettingsResponse._();

  factory GetUserSettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserSettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserSettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOM<UserSettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: UserSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserSettingsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserSettingsResponse copyWith(
          void Function(GetUserSettingsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserSettingsResponse))
          as GetUserSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserSettingsResponse create() => GetUserSettingsResponse._();
  @$core.override
  GetUserSettingsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetUserSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserSettingsResponse>(create);
  static GetUserSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserSettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(UserSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  UserSettings ensureSettings() => $_ensure(0);
}

class UpdateUserSettingsRequest extends $pb.GeneratedMessage {
  factory UpdateUserSettingsRequest({
    UserSettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  UpdateUserSettingsRequest._();

  factory UpdateUserSettingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserSettingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserSettingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOM<UserSettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: UserSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserSettingsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserSettingsRequest copyWith(
          void Function(UpdateUserSettingsRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateUserSettingsRequest))
          as UpdateUserSettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserSettingsRequest create() => UpdateUserSettingsRequest._();
  @$core.override
  UpdateUserSettingsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateUserSettingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserSettingsRequest>(create);
  static UpdateUserSettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  UserSettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(UserSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  UserSettings ensureSettings() => $_ensure(0);
}

class UpdateUserSettingsResponse extends $pb.GeneratedMessage {
  factory UpdateUserSettingsResponse({
    UserSettings? settings,
  }) {
    final result = create();
    if (settings != null) result.settings = settings;
    return result;
  }

  UpdateUserSettingsResponse._();

  factory UpdateUserSettingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateUserSettingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateUserSettingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'settings.v1'),
      createEmptyInstance: create)
    ..aOM<UserSettings>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: UserSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserSettingsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateUserSettingsResponse copyWith(
          void Function(UpdateUserSettingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateUserSettingsResponse))
          as UpdateUserSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserSettingsResponse create() => UpdateUserSettingsResponse._();
  @$core.override
  UpdateUserSettingsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateUserSettingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateUserSettingsResponse>(create);
  static UpdateUserSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserSettings get settings => $_getN(0);
  @$pb.TagNumber(1)
  set settings(UserSettings value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSettings() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettings() => $_clearField(1);
  @$pb.TagNumber(1)
  UserSettings ensureSettings() => $_ensure(0);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
