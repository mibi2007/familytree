// This is a generated file - do not edit.
//
// Generated from proto/auth/v1/auth.proto.

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
    as $2;

import '../../common/v1/common.pb.dart' as $1;
import 'auth.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'auth.pbenum.dart';

class InviteToken extends $pb.GeneratedMessage {
  factory InviteToken({
    $core.String? token,
    TokenPurpose? purpose,
    $core.String? associatedId,
    $2.Timestamp? expiresAt,
    $core.bool? isUsed,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (purpose != null) result.purpose = purpose;
    if (associatedId != null) result.associatedId = associatedId;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (isUsed != null) result.isUsed = isUsed;
    return result;
  }

  InviteToken._();

  factory InviteToken.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InviteToken.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InviteToken',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aE<TokenPurpose>(2, _omitFieldNames ? '' : 'purpose',
        enumValues: TokenPurpose.values)
    ..aOS(3, _omitFieldNames ? '' : 'associatedId')
    ..aOM<$2.Timestamp>(4, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $2.Timestamp.create)
    ..aOB(5, _omitFieldNames ? '' : 'isUsed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteToken clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InviteToken copyWith(void Function(InviteToken) updates) =>
      super.copyWith((message) => updates(message as InviteToken))
          as InviteToken;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InviteToken create() => InviteToken._();
  @$core.override
  InviteToken createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InviteToken getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InviteToken>(create);
  static InviteToken? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  TokenPurpose get purpose => $_getN(1);
  @$pb.TagNumber(2)
  set purpose(TokenPurpose value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get associatedId => $_getSZ(2);
  @$pb.TagNumber(3)
  set associatedId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssociatedId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssociatedId() => $_clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get expiresAt => $_getN(3);
  @$pb.TagNumber(4)
  set expiresAt($2.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureExpiresAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get isUsed => $_getBF(4);
  @$pb.TagNumber(5)
  set isUsed($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsUsed() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsUsed() => $_clearField(5);
}

class GenerateInviteTokenRequest extends $pb.GeneratedMessage {
  factory GenerateInviteTokenRequest({
    TokenPurpose? purpose,
    $core.String? associatedId,
    $fixnum.Int64? lifetimeSeconds,
  }) {
    final result = create();
    if (purpose != null) result.purpose = purpose;
    if (associatedId != null) result.associatedId = associatedId;
    if (lifetimeSeconds != null) result.lifetimeSeconds = lifetimeSeconds;
    return result;
  }

  GenerateInviteTokenRequest._();

  factory GenerateInviteTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateInviteTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateInviteTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aE<TokenPurpose>(1, _omitFieldNames ? '' : 'purpose',
        enumValues: TokenPurpose.values)
    ..aOS(2, _omitFieldNames ? '' : 'associatedId')
    ..aInt64(3, _omitFieldNames ? '' : 'lifetimeSeconds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInviteTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateInviteTokenRequest copyWith(
          void Function(GenerateInviteTokenRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateInviteTokenRequest))
          as GenerateInviteTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateInviteTokenRequest create() => GenerateInviteTokenRequest._();
  @$core.override
  GenerateInviteTokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GenerateInviteTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateInviteTokenRequest>(create);
  static GenerateInviteTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TokenPurpose get purpose => $_getN(0);
  @$pb.TagNumber(1)
  set purpose(TokenPurpose value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPurpose() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurpose() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get associatedId => $_getSZ(1);
  @$pb.TagNumber(2)
  set associatedId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAssociatedId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssociatedId() => $_clearField(2);

  /// Expiration in seconds: 3600 (1h), 86400 (1d), 0 (unlimited)
  @$pb.TagNumber(3)
  $fixnum.Int64 get lifetimeSeconds => $_getI64(2);
  @$pb.TagNumber(3)
  set lifetimeSeconds($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLifetimeSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearLifetimeSeconds() => $_clearField(3);
}

class ValidateInviteTokenRequest extends $pb.GeneratedMessage {
  factory ValidateInviteTokenRequest({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  ValidateInviteTokenRequest._();

  factory ValidateInviteTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateInviteTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateInviteTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateInviteTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateInviteTokenRequest copyWith(
          void Function(ValidateInviteTokenRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ValidateInviteTokenRequest))
          as ValidateInviteTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInviteTokenRequest create() => ValidateInviteTokenRequest._();
  @$core.override
  ValidateInviteTokenRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ValidateInviteTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateInviteTokenRequest>(create);
  static ValidateInviteTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class ValidateInviteTokenResponse extends $pb.GeneratedMessage {
  factory ValidateInviteTokenResponse({
    $core.bool? isValid,
    TokenPurpose? purpose,
    $core.String? associatedId,
  }) {
    final result = create();
    if (isValid != null) result.isValid = isValid;
    if (purpose != null) result.purpose = purpose;
    if (associatedId != null) result.associatedId = associatedId;
    return result;
  }

  ValidateInviteTokenResponse._();

  factory ValidateInviteTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateInviteTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateInviteTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aE<TokenPurpose>(2, _omitFieldNames ? '' : 'purpose',
        enumValues: TokenPurpose.values)
    ..aOS(3, _omitFieldNames ? '' : 'associatedId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateInviteTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateInviteTokenResponse copyWith(
          void Function(ValidateInviteTokenResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ValidateInviteTokenResponse))
          as ValidateInviteTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateInviteTokenResponse create() =>
      ValidateInviteTokenResponse._();
  @$core.override
  ValidateInviteTokenResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ValidateInviteTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateInviteTokenResponse>(create);
  static ValidateInviteTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => $_clearField(1);

  @$pb.TagNumber(2)
  TokenPurpose get purpose => $_getN(1);
  @$pb.TagNumber(2)
  set purpose(TokenPurpose value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPurpose() => $_has(1);
  @$pb.TagNumber(2)
  void clearPurpose() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get associatedId => $_getSZ(2);
  @$pb.TagNumber(3)
  set associatedId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssociatedId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssociatedId() => $_clearField(3);
}

class RequestAdminAccessRequest extends $pb.GeneratedMessage {
  factory RequestAdminAccessRequest({
    $core.String? invitationToken,
    $core.String? requestedRole,
    $core.String? reason,
  }) {
    final result = create();
    if (invitationToken != null) result.invitationToken = invitationToken;
    if (requestedRole != null) result.requestedRole = requestedRole;
    if (reason != null) result.reason = reason;
    return result;
  }

  RequestAdminAccessRequest._();

  factory RequestAdminAccessRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestAdminAccessRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestAdminAccessRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invitationToken')
    ..aOS(2, _omitFieldNames ? '' : 'requestedRole')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestAdminAccessRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestAdminAccessRequest copyWith(
          void Function(RequestAdminAccessRequest) updates) =>
      super.copyWith((message) => updates(message as RequestAdminAccessRequest))
          as RequestAdminAccessRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestAdminAccessRequest create() => RequestAdminAccessRequest._();
  @$core.override
  RequestAdminAccessRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static RequestAdminAccessRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestAdminAccessRequest>(create);
  static RequestAdminAccessRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get requestedRole => $_getSZ(1);
  @$pb.TagNumber(2)
  set requestedRole($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRequestedRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequestedRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class AdminAccessRequest extends $pb.GeneratedMessage {
  factory AdminAccessRequest({
    $core.String? id,
    $core.String? userId,
    $core.String? requestedRole,
    RequestStatus? status,
    $core.String? reason,
    $core.String? reviewedBy,
    $2.Timestamp? updatedAt,
    $1.UserProfile? userProfile,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (requestedRole != null) result.requestedRole = requestedRole;
    if (status != null) result.status = status;
    if (reason != null) result.reason = reason;
    if (reviewedBy != null) result.reviewedBy = reviewedBy;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (userProfile != null) result.userProfile = userProfile;
    return result;
  }

  AdminAccessRequest._();

  factory AdminAccessRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminAccessRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminAccessRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'requestedRole')
    ..aE<RequestStatus>(4, _omitFieldNames ? '' : 'status',
        enumValues: RequestStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'reason')
    ..aOS(6, _omitFieldNames ? '' : 'reviewedBy')
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $2.Timestamp.create)
    ..aOM<$1.UserProfile>(8, _omitFieldNames ? '' : 'userProfile',
        subBuilder: $1.UserProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAccessRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminAccessRequest copyWith(void Function(AdminAccessRequest) updates) =>
      super.copyWith((message) => updates(message as AdminAccessRequest))
          as AdminAccessRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminAccessRequest create() => AdminAccessRequest._();
  @$core.override
  AdminAccessRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AdminAccessRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminAccessRequest>(create);
  static AdminAccessRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get requestedRole => $_getSZ(2);
  @$pb.TagNumber(3)
  set requestedRole($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRequestedRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRequestedRole() => $_clearField(3);

  @$pb.TagNumber(4)
  RequestStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(RequestStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get reason => $_getSZ(4);
  @$pb.TagNumber(5)
  set reason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearReason() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get reviewedBy => $_getSZ(5);
  @$pb.TagNumber(6)
  set reviewedBy($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReviewedBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearReviewedBy() => $_clearField(6);

  @$pb.TagNumber(7)
  $2.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($2.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureUpdatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.UserProfile get userProfile => $_getN(7);
  @$pb.TagNumber(8)
  set userProfile($1.UserProfile value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUserProfile() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserProfile() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.UserProfile ensureUserProfile() => $_ensure(7);
}

class ListAdminRequestsRequest extends $pb.GeneratedMessage {
  factory ListAdminRequestsRequest({
    RequestStatus? filterStatus,
    $1.PaginatedRequest? pagination,
  }) {
    final result = create();
    if (filterStatus != null) result.filterStatus = filterStatus;
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListAdminRequestsRequest._();

  factory ListAdminRequestsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAdminRequestsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAdminRequestsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aE<RequestStatus>(1, _omitFieldNames ? '' : 'filterStatus',
        enumValues: RequestStatus.values)
    ..aOM<$1.PaginatedRequest>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginatedRequest.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAdminRequestsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAdminRequestsRequest copyWith(
          void Function(ListAdminRequestsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAdminRequestsRequest))
          as ListAdminRequestsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAdminRequestsRequest create() => ListAdminRequestsRequest._();
  @$core.override
  ListAdminRequestsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAdminRequestsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAdminRequestsRequest>(create);
  static ListAdminRequestsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RequestStatus get filterStatus => $_getN(0);
  @$pb.TagNumber(1)
  set filterStatus(RequestStatus value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilterStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilterStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.PaginatedRequest get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginatedRequest value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginatedRequest ensurePagination() => $_ensure(1);
}

class ListAdminRequestsResponse extends $pb.GeneratedMessage {
  factory ListAdminRequestsResponse({
    $core.Iterable<AdminAccessRequest>? requests,
    $1.PaginatedResponse? pagination,
  }) {
    final result = create();
    if (requests != null) result.requests.addAll(requests);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListAdminRequestsResponse._();

  factory ListAdminRequestsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAdminRequestsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAdminRequestsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..pPM<AdminAccessRequest>(1, _omitFieldNames ? '' : 'requests',
        subBuilder: AdminAccessRequest.create)
    ..aOM<$1.PaginatedResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $1.PaginatedResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAdminRequestsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAdminRequestsResponse copyWith(
          void Function(ListAdminRequestsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAdminRequestsResponse))
          as ListAdminRequestsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAdminRequestsResponse create() => ListAdminRequestsResponse._();
  @$core.override
  ListAdminRequestsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAdminRequestsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAdminRequestsResponse>(create);
  static ListAdminRequestsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AdminAccessRequest> get requests => $_getList(0);

  @$pb.TagNumber(2)
  $1.PaginatedResponse get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($1.PaginatedResponse value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.PaginatedResponse ensurePagination() => $_ensure(1);
}

class ReviewAdminRequestRequest extends $pb.GeneratedMessage {
  factory ReviewAdminRequestRequest({
    $core.String? requestId,
    RequestStatus? decision,
  }) {
    final result = create();
    if (requestId != null) result.requestId = requestId;
    if (decision != null) result.decision = decision;
    return result;
  }

  ReviewAdminRequestRequest._();

  factory ReviewAdminRequestRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReviewAdminRequestRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewAdminRequestRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'requestId')
    ..aE<RequestStatus>(2, _omitFieldNames ? '' : 'decision',
        enumValues: RequestStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewAdminRequestRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewAdminRequestRequest copyWith(
          void Function(ReviewAdminRequestRequest) updates) =>
      super.copyWith((message) => updates(message as ReviewAdminRequestRequest))
          as ReviewAdminRequestRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReviewAdminRequestRequest create() => ReviewAdminRequestRequest._();
  @$core.override
  ReviewAdminRequestRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReviewAdminRequestRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReviewAdminRequestRequest>(create);
  static ReviewAdminRequestRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get requestId => $_getSZ(0);
  @$pb.TagNumber(1)
  set requestId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => $_clearField(1);

  @$pb.TagNumber(2)
  RequestStatus get decision => $_getN(1);
  @$pb.TagNumber(2)
  set decision(RequestStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDecision() => $_has(1);
  @$pb.TagNumber(2)
  void clearDecision() => $_clearField(2);
}

class SyncUserProfileRequest extends $pb.GeneratedMessage {
  factory SyncUserProfileRequest({
    $core.String? displayName,
    $core.String? photoUrl,
  }) {
    final result = create();
    if (displayName != null) result.displayName = displayName;
    if (photoUrl != null) result.photoUrl = photoUrl;
    return result;
  }

  SyncUserProfileRequest._();

  factory SyncUserProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncUserProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncUserProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'displayName')
    ..aOS(2, _omitFieldNames ? '' : 'photoUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncUserProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncUserProfileRequest copyWith(
          void Function(SyncUserProfileRequest) updates) =>
      super.copyWith((message) => updates(message as SyncUserProfileRequest))
          as SyncUserProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncUserProfileRequest create() => SyncUserProfileRequest._();
  @$core.override
  SyncUserProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncUserProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncUserProfileRequest>(create);
  static SyncUserProfileRequest? _defaultInstance;

  /// Data from Firebase JWT
  @$pb.TagNumber(1)
  $core.String get displayName => $_getSZ(0);
  @$pb.TagNumber(1)
  set displayName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDisplayName() => $_has(0);
  @$pb.TagNumber(1)
  void clearDisplayName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get photoUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set photoUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPhotoUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhotoUrl() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
