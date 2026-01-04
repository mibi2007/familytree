// This is a generated file - do not edit.
//
// Generated from proto/family/v1/family.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use familyDescriptor instead')
const Family$json = {
  '1': 'Family',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'owner_id', '3': 3, '4': 1, '5': 9, '10': 'ownerId'},
    {
      '1': 'ai_behavior_instructions',
      '3': 4,
      '4': 1,
      '5': 9,
      '10': 'aiBehaviorInstructions'
    },
    {
      '1': 'created_at',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
  ],
};

/// Descriptor for `Family`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyDescriptor = $convert.base64Decode(
    'CgZGYW1pbHkSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSGQoIb3duZXJfaW'
    'QYAyABKAlSB293bmVySWQSOAoYYWlfYmVoYXZpb3JfaW5zdHJ1Y3Rpb25zGAQgASgJUhZhaUJl'
    'aGF2aW9ySW5zdHJ1Y3Rpb25zEjkKCmNyZWF0ZWRfYXQYBSABKAsyGi5nb29nbGUucHJvdG9idW'
    'YuVGltZXN0YW1wUgljcmVhdGVkQXQ=');

@$core.Deprecated('Use memberDescriptor instead')
const Member$json = {
  '1': 'Member',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'family_id', '3': 2, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'display_name', '3': 3, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'birth_date', '3': 4, '4': 1, '5': 9, '10': 'birthDate'},
    {'1': 'gender', '3': 5, '4': 1, '5': 9, '10': 'gender'},
    {'1': 'level', '3': 6, '4': 1, '5': 5, '10': 'level'},
    {'1': 'parent_id', '3': 7, '4': 1, '5': 9, '10': 'parentId'},
    {'1': 'spouse_id', '3': 8, '4': 1, '5': 9, '10': 'spouseId'},
    {'1': 'user_id', '3': 9, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Member`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberDescriptor = $convert.base64Decode(
    'CgZNZW1iZXISDgoCaWQYASABKAlSAmlkEhsKCWZhbWlseV9pZBgCIAEoCVIIZmFtaWx5SWQSIQ'
    'oMZGlzcGxheV9uYW1lGAMgASgJUgtkaXNwbGF5TmFtZRIdCgpiaXJ0aF9kYXRlGAQgASgJUgli'
    'aXJ0aERhdGUSFgoGZ2VuZGVyGAUgASgJUgZnZW5kZXISFAoFbGV2ZWwYBiABKAVSBWxldmVsEh'
    'sKCXBhcmVudF9pZBgHIAEoCVIIcGFyZW50SWQSGwoJc3BvdXNlX2lkGAggASgJUghzcG91c2VJ'
    'ZBIXCgd1c2VyX2lkGAkgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use createFamilyRequestDescriptor instead')
const CreateFamilyRequest$json = {
  '1': 'CreateFamilyRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `CreateFamilyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createFamilyRequestDescriptor = $convert
    .base64Decode('ChNDcmVhdGVGYW1pbHlSZXF1ZXN0EhIKBG5hbWUYASABKAlSBG5hbWU=');

@$core.Deprecated('Use getFamilyRequestDescriptor instead')
const GetFamilyRequest$json = {
  '1': 'GetFamilyRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetFamilyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyRequestDescriptor =
    $convert.base64Decode('ChBHZXRGYW1pbHlSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use updateFamilyOwnerRequestDescriptor instead')
const UpdateFamilyOwnerRequest$json = {
  '1': 'UpdateFamilyOwnerRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'new_owner_id', '3': 2, '4': 1, '5': 9, '10': 'newOwnerId'},
  ],
};

/// Descriptor for `UpdateFamilyOwnerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateFamilyOwnerRequestDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVGYW1pbHlPd25lclJlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUghmYW1pbHlJZB'
        'IgCgxuZXdfb3duZXJfaWQYAiABKAlSCm5ld093bmVySWQ=');

@$core.Deprecated('Use leaveFamilyRequestDescriptor instead')
const LeaveFamilyRequest$json = {
  '1': 'LeaveFamilyRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
  ],
};

/// Descriptor for `LeaveFamilyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveFamilyRequestDescriptor =
    $convert.base64Decode(
        'ChJMZWF2ZUZhbWlseVJlcXVlc3QSGwoJZmFtaWx5X2lkGAEgASgJUghmYW1pbHlJZA==');

@$core.Deprecated('Use addMemberRequestDescriptor instead')
const AddMemberRequest$json = {
  '1': 'AddMemberRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'display_name', '3': 2, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'parent_id', '3': 3, '4': 1, '5': 9, '10': 'parentId'},
    {'1': 'spouse_id', '3': 4, '4': 1, '5': 9, '10': 'spouseId'},
  ],
};

/// Descriptor for `AddMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMemberRequestDescriptor = $convert.base64Decode(
    'ChBBZGRNZW1iZXJSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSIQoMZGlzcG'
    'xheV9uYW1lGAIgASgJUgtkaXNwbGF5TmFtZRIbCglwYXJlbnRfaWQYAyABKAlSCHBhcmVudElk'
    'EhsKCXNwb3VzZV9pZBgEIAEoCVIIc3BvdXNlSWQ=');

@$core.Deprecated('Use updateMemberRequestDescriptor instead')
const UpdateMemberRequest$json = {
  '1': 'UpdateMemberRequest',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.family.v1.Member',
      '10': 'member'
    },
  ],
};

/// Descriptor for `UpdateMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateMemberRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVNZW1iZXJSZXF1ZXN0EikKBm1lbWJlchgBIAEoCzIRLmZhbWlseS52MS5NZW1iZX'
    'JSBm1lbWJlcg==');

@$core.Deprecated('Use deleteMemberRequestDescriptor instead')
const DeleteMemberRequest$json = {
  '1': 'DeleteMemberRequest',
  '2': [
    {'1': 'member_id', '3': 1, '4': 1, '5': 9, '10': 'memberId'},
  ],
};

/// Descriptor for `DeleteMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMemberRequestDescriptor =
    $convert.base64Decode(
        'ChNEZWxldGVNZW1iZXJSZXF1ZXN0EhsKCW1lbWJlcl9pZBgBIAEoCVIIbWVtYmVySWQ=');

@$core.Deprecated('Use getFamilyTreeRequestDescriptor instead')
const GetFamilyTreeRequest$json = {
  '1': 'GetFamilyTreeRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'version_hash', '3': 2, '4': 1, '5': 9, '10': 'versionHash'},
  ],
};

/// Descriptor for `GetFamilyTreeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFamilyTreeRequestDescriptor = $convert.base64Decode(
    'ChRHZXRGYW1pbHlUcmVlUmVxdWVzdBIbCglmYW1pbHlfaWQYASABKAlSCGZhbWlseUlkEiEKDH'
    'ZlcnNpb25faGFzaBgCIAEoCVILdmVyc2lvbkhhc2g=');

@$core.Deprecated('Use familyTreeDescriptor instead')
const FamilyTree$json = {
  '1': 'FamilyTree',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'version_hash', '3': 2, '4': 1, '5': 9, '10': 'versionHash'},
    {
      '1': 'members',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.family.v1.Member',
      '10': 'members'
    },
    {'1': 'not_modified', '3': 4, '4': 1, '5': 8, '10': 'notModified'},
  ],
};

/// Descriptor for `FamilyTree`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List familyTreeDescriptor = $convert.base64Decode(
    'CgpGYW1pbHlUcmVlEhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSIQoMdmVyc2lvbl9oYX'
    'NoGAIgASgJUgt2ZXJzaW9uSGFzaBIrCgdtZW1iZXJzGAMgAygLMhEuZmFtaWx5LnYxLk1lbWJl'
    'clIHbWVtYmVycxIhCgxub3RfbW9kaWZpZWQYBCABKAhSC25vdE1vZGlmaWVk');
