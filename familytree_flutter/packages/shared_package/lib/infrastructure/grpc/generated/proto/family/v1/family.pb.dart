// This is a generated file - do not edit.
//
// Generated from proto/family/v1/family.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart'
    as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Family extends $pb.GeneratedMessage {
  factory Family({
    $core.String? id,
    $core.String? name,
    $core.String? ownerId,
    $core.String? aiBehaviorInstructions,
    $2.Timestamp? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (ownerId != null) result.ownerId = ownerId;
    if (aiBehaviorInstructions != null)
      result.aiBehaviorInstructions = aiBehaviorInstructions;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Family._();

  factory Family.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Family.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Family',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'ownerId')
    ..aOS(4, _omitFieldNames ? '' : 'aiBehaviorInstructions')
    ..aOM<$2.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Family clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Family copyWith(void Function(Family) updates) =>
      super.copyWith((message) => updates(message as Family)) as Family;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Family create() => Family._();
  @$core.override
  Family createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Family getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Family>(create);
  static Family? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get ownerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set ownerId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOwnerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwnerId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get aiBehaviorInstructions => $_getSZ(3);
  @$pb.TagNumber(4)
  set aiBehaviorInstructions($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAiBehaviorInstructions() => $_has(3);
  @$pb.TagNumber(4)
  void clearAiBehaviorInstructions() => $_clearField(4);

  @$pb.TagNumber(5)
  $2.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($2.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureCreatedAt() => $_ensure(4);
}

class Member extends $pb.GeneratedMessage {
  factory Member({
    $core.String? id,
    $core.String? familyId,
    $core.String? displayName,
    $core.String? birthDate,
    $core.String? gender,
    $core.int? level,
    $core.String? parentId,
    $core.String? spouseId,
    $core.String? userId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (familyId != null) result.familyId = familyId;
    if (displayName != null) result.displayName = displayName;
    if (birthDate != null) result.birthDate = birthDate;
    if (gender != null) result.gender = gender;
    if (level != null) result.level = level;
    if (parentId != null) result.parentId = parentId;
    if (spouseId != null) result.spouseId = spouseId;
    if (userId != null) result.userId = userId;
    return result;
  }

  Member._();

  factory Member.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Member.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Member',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'birthDate')
    ..aOS(5, _omitFieldNames ? '' : 'gender')
    ..aI(6, _omitFieldNames ? '' : 'level')
    ..aOS(7, _omitFieldNames ? '' : 'parentId')
    ..aOS(8, _omitFieldNames ? '' : 'spouseId')
    ..aOS(9, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Member clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Member copyWith(void Function(Member) updates) =>
      super.copyWith((message) => updates(message as Member)) as Member;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Member create() => Member._();
  @$core.override
  Member createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Member getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Member>(create);
  static Member? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get birthDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set birthDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBirthDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearBirthDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get gender => $_getSZ(4);
  @$pb.TagNumber(5)
  set gender($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGender() => $_has(4);
  @$pb.TagNumber(5)
  void clearGender() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get level => $_getIZ(5);
  @$pb.TagNumber(6)
  set level($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearLevel() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get parentId => $_getSZ(6);
  @$pb.TagNumber(7)
  set parentId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasParentId() => $_has(6);
  @$pb.TagNumber(7)
  void clearParentId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get spouseId => $_getSZ(7);
  @$pb.TagNumber(8)
  set spouseId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSpouseId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpouseId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get userId => $_getSZ(8);
  @$pb.TagNumber(9)
  set userId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUserId() => $_has(8);
  @$pb.TagNumber(9)
  void clearUserId() => $_clearField(9);
}

class CreateFamilyRequest extends $pb.GeneratedMessage {
  factory CreateFamilyRequest({
    $core.String? name,
  }) {
    final result = create();
    if (name != null) result.name = name;
    return result;
  }

  CreateFamilyRequest._();

  factory CreateFamilyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFamilyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFamilyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyRequest copyWith(void Function(CreateFamilyRequest) updates) =>
      super.copyWith((message) => updates(message as CreateFamilyRequest))
          as CreateFamilyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFamilyRequest create() => CreateFamilyRequest._();
  @$core.override
  CreateFamilyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateFamilyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFamilyRequest>(create);
  static CreateFamilyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);
}

class GetFamilyRequest extends $pb.GeneratedMessage {
  factory GetFamilyRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetFamilyRequest._();

  factory GetFamilyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyRequest copyWith(void Function(GetFamilyRequest) updates) =>
      super.copyWith((message) => updates(message as GetFamilyRequest))
          as GetFamilyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyRequest create() => GetFamilyRequest._();
  @$core.override
  GetFamilyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFamilyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyRequest>(create);
  static GetFamilyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class UpdateFamilyOwnerRequest extends $pb.GeneratedMessage {
  factory UpdateFamilyOwnerRequest({
    $core.String? familyId,
    $core.String? newOwnerId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (newOwnerId != null) result.newOwnerId = newOwnerId;
    return result;
  }

  UpdateFamilyOwnerRequest._();

  factory UpdateFamilyOwnerRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFamilyOwnerRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFamilyOwnerRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'newOwnerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyOwnerRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyOwnerRequest copyWith(
          void Function(UpdateFamilyOwnerRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateFamilyOwnerRequest))
          as UpdateFamilyOwnerRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFamilyOwnerRequest create() => UpdateFamilyOwnerRequest._();
  @$core.override
  UpdateFamilyOwnerRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyOwnerRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFamilyOwnerRequest>(create);
  static UpdateFamilyOwnerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newOwnerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set newOwnerId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewOwnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewOwnerId() => $_clearField(2);
}

class LeaveFamilyRequest extends $pb.GeneratedMessage {
  factory LeaveFamilyRequest({
    $core.String? familyId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    return result;
  }

  LeaveFamilyRequest._();

  factory LeaveFamilyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaveFamilyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveFamilyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyRequest copyWith(void Function(LeaveFamilyRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveFamilyRequest))
          as LeaveFamilyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveFamilyRequest create() => LeaveFamilyRequest._();
  @$core.override
  LeaveFamilyRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static LeaveFamilyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveFamilyRequest>(create);
  static LeaveFamilyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);
}

class AddMemberRequest extends $pb.GeneratedMessage {
  factory AddMemberRequest({
    $core.String? familyId,
    $core.String? displayName,
    $core.String? parentId,
    $core.String? spouseId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (displayName != null) result.displayName = displayName;
    if (parentId != null) result.parentId = parentId;
    if (spouseId != null) result.spouseId = spouseId;
    return result;
  }

  AddMemberRequest._();

  factory AddMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'parentId')
    ..aOS(4, _omitFieldNames ? '' : 'spouseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMemberRequest copyWith(void Function(AddMemberRequest) updates) =>
      super.copyWith((message) => updates(message as AddMemberRequest))
          as AddMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddMemberRequest create() => AddMemberRequest._();
  @$core.override
  AddMemberRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AddMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMemberRequest>(create);
  static AddMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get parentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set parentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasParentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearParentId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get spouseId => $_getSZ(3);
  @$pb.TagNumber(4)
  set spouseId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpouseId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpouseId() => $_clearField(4);
}

class UpdateMemberRequest extends $pb.GeneratedMessage {
  factory UpdateMemberRequest({
    Member? member,
  }) {
    final result = create();
    if (member != null) result.member = member;
    return result;
  }

  UpdateMemberRequest._();

  factory UpdateMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOM<Member>(1, _omitFieldNames ? '' : 'member', subBuilder: Member.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMemberRequest copyWith(void Function(UpdateMemberRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateMemberRequest))
          as UpdateMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMemberRequest create() => UpdateMemberRequest._();
  @$core.override
  UpdateMemberRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateMemberRequest>(create);
  static UpdateMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Member get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(Member value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  Member ensureMember() => $_ensure(0);
}

class DeleteMemberRequest extends $pb.GeneratedMessage {
  factory DeleteMemberRequest({
    $core.String? memberId,
  }) {
    final result = create();
    if (memberId != null) result.memberId = memberId;
    return result;
  }

  DeleteMemberRequest._();

  factory DeleteMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memberId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMemberRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMemberRequest copyWith(void Function(DeleteMemberRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteMemberRequest))
          as DeleteMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteMemberRequest create() => DeleteMemberRequest._();
  @$core.override
  DeleteMemberRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DeleteMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMemberRequest>(create);
  static DeleteMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get memberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberId() => $_clearField(1);
}

class GetFamilyTreeRequest extends $pb.GeneratedMessage {
  factory GetFamilyTreeRequest({
    $core.String? familyId,
    $core.String? versionHash,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (versionHash != null) result.versionHash = versionHash;
    return result;
  }

  GetFamilyTreeRequest._();

  factory GetFamilyTreeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyTreeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyTreeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'versionHash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTreeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTreeRequest copyWith(void Function(GetFamilyTreeRequest) updates) =>
      super.copyWith((message) => updates(message as GetFamilyTreeRequest))
          as GetFamilyTreeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyTreeRequest create() => GetFamilyTreeRequest._();
  @$core.override
  GetFamilyTreeRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetFamilyTreeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyTreeRequest>(create);
  static GetFamilyTreeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get versionHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set versionHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersionHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersionHash() => $_clearField(2);
}

class FamilyTree extends $pb.GeneratedMessage {
  factory FamilyTree({
    $core.String? familyId,
    $core.String? versionHash,
    $core.Iterable<Member>? members,
    $core.bool? notModified,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (versionHash != null) result.versionHash = versionHash;
    if (members != null) result.members.addAll(members);
    if (notModified != null) result.notModified = notModified;
    return result;
  }

  FamilyTree._();

  factory FamilyTree.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyTree.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyTree',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'family.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'versionHash')
    ..pPM<Member>(3, _omitFieldNames ? '' : 'members',
        subBuilder: Member.create)
    ..aOB(4, _omitFieldNames ? '' : 'notModified')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyTree clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyTree copyWith(void Function(FamilyTree) updates) =>
      super.copyWith((message) => updates(message as FamilyTree)) as FamilyTree;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyTree create() => FamilyTree._();
  @$core.override
  FamilyTree createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FamilyTree getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyTree>(create);
  static FamilyTree? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get versionHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set versionHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVersionHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearVersionHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<Member> get members => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get notModified => $_getBF(3);
  @$pb.TagNumber(4)
  set notModified($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNotModified() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotModified() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
