// This is a generated file - do not edit.
//
// Generated from proto/system/v1/system.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class HealthCheckRequest extends $pb.GeneratedMessage {
  factory HealthCheckRequest() => create();

  HealthCheckRequest._();

  factory HealthCheckRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthCheckRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthCheckRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'system.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthCheckRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthCheckRequest copyWith(void Function(HealthCheckRequest) updates) =>
      super.copyWith((message) => updates(message as HealthCheckRequest))
          as HealthCheckRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest create() => HealthCheckRequest._();
  @$core.override
  HealthCheckRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthCheckRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthCheckRequest>(create);
  static HealthCheckRequest? _defaultInstance;
}

class HealthCheckResponse extends $pb.GeneratedMessage {
  factory HealthCheckResponse({
    $core.String? overallStatus,
    $1.Timestamp? checkedAt,
    ComponentStatus? server,
    ComponentStatus? database,
    ComponentStatus? storage,
  }) {
    final result = create();
    if (overallStatus != null) result.overallStatus = overallStatus;
    if (checkedAt != null) result.checkedAt = checkedAt;
    if (server != null) result.server = server;
    if (database != null) result.database = database;
    if (storage != null) result.storage = storage;
    return result;
  }

  HealthCheckResponse._();

  factory HealthCheckResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HealthCheckResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HealthCheckResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'system.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'overallStatus')
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'checkedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<ComponentStatus>(3, _omitFieldNames ? '' : 'server',
        subBuilder: ComponentStatus.create)
    ..aOM<ComponentStatus>(4, _omitFieldNames ? '' : 'database',
        subBuilder: ComponentStatus.create)
    ..aOM<ComponentStatus>(5, _omitFieldNames ? '' : 'storage',
        subBuilder: ComponentStatus.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthCheckResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HealthCheckResponse copyWith(void Function(HealthCheckResponse) updates) =>
      super.copyWith((message) => updates(message as HealthCheckResponse))
          as HealthCheckResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse create() => HealthCheckResponse._();
  @$core.override
  HealthCheckResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HealthCheckResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HealthCheckResponse>(create);
  static HealthCheckResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get overallStatus => $_getSZ(0);
  @$pb.TagNumber(1)
  set overallStatus($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOverallStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearOverallStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get checkedAt => $_getN(1);
  @$pb.TagNumber(2)
  set checkedAt($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCheckedAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearCheckedAt() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureCheckedAt() => $_ensure(1);

  @$pb.TagNumber(3)
  ComponentStatus get server => $_getN(2);
  @$pb.TagNumber(3)
  set server(ComponentStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasServer() => $_has(2);
  @$pb.TagNumber(3)
  void clearServer() => $_clearField(3);
  @$pb.TagNumber(3)
  ComponentStatus ensureServer() => $_ensure(2);

  @$pb.TagNumber(4)
  ComponentStatus get database => $_getN(3);
  @$pb.TagNumber(4)
  set database(ComponentStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDatabase() => $_has(3);
  @$pb.TagNumber(4)
  void clearDatabase() => $_clearField(4);
  @$pb.TagNumber(4)
  ComponentStatus ensureDatabase() => $_ensure(3);

  @$pb.TagNumber(5)
  ComponentStatus get storage => $_getN(4);
  @$pb.TagNumber(5)
  set storage(ComponentStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStorage() => $_has(4);
  @$pb.TagNumber(5)
  void clearStorage() => $_clearField(5);
  @$pb.TagNumber(5)
  ComponentStatus ensureStorage() => $_ensure(4);
}

class ComponentStatus extends $pb.GeneratedMessage {
  factory ComponentStatus({
    $core.String? name,
    $core.String? status,
    $core.String? message,
    $fixnum.Int64? responseTimeMs,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    if (responseTimeMs != null) result.responseTimeMs = responseTimeMs;
    return result;
  }

  ComponentStatus._();

  factory ComponentStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComponentStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComponentStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'system.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aInt64(4, _omitFieldNames ? '' : 'responseTimeMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComponentStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComponentStatus copyWith(void Function(ComponentStatus) updates) =>
      super.copyWith((message) => updates(message as ComponentStatus))
          as ComponentStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComponentStatus create() => ComponentStatus._();
  @$core.override
  ComponentStatus createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ComponentStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComponentStatus>(create);
  static ComponentStatus? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get responseTimeMs => $_getI64(3);
  @$pb.TagNumber(4)
  set responseTimeMs($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResponseTimeMs() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseTimeMs() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
