// This is a generated file - do not edit.
//
// Generated from proto/auth/v1/auth.proto.

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

@$core.Deprecated('Use tokenPurposeDescriptor instead')
const TokenPurpose$json = {
  '1': 'TokenPurpose',
  '2': [
    {'1': 'TOKEN_PURPOSE_UNSPECIFIED', '2': 0},
    {'1': 'TOKEN_PURPOSE_ADMIN_ONBOARDING', '2': 1},
    {'1': 'TOKEN_PURPOSE_FAMILY_INVITE', '2': 2},
    {'1': 'TOKEN_PURPOSE_SUPPORT_GRANT', '2': 3},
  ],
};

/// Descriptor for `TokenPurpose`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List tokenPurposeDescriptor = $convert.base64Decode(
    'CgxUb2tlblB1cnBvc2USHQoZVE9LRU5fUFVSUE9TRV9VTlNQRUNJRklFRBAAEiIKHlRPS0VOX1'
    'BVUlBPU0VfQURNSU5fT05CT0FSRElORxABEh8KG1RPS0VOX1BVUlBPU0VfRkFNSUxZX0lOVklU'
    'RRACEh8KG1RPS0VOX1BVUlBPU0VfU1VQUE9SVF9HUkFOVBAD');

@$core.Deprecated('Use requestStatusDescriptor instead')
const RequestStatus$json = {
  '1': 'RequestStatus',
  '2': [
    {'1': 'REQUEST_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'REQUEST_STATUS_PENDING', '2': 1},
    {'1': 'REQUEST_STATUS_APPROVED', '2': 2},
    {'1': 'REQUEST_STATUS_REJECTED', '2': 3},
  ],
};

/// Descriptor for `RequestStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List requestStatusDescriptor = $convert.base64Decode(
    'Cg1SZXF1ZXN0U3RhdHVzEh4KGlJFUVVFU1RfU1RBVFVTX1VOU1BFQ0lGSUVEEAASGgoWUkVRVU'
    'VTVF9TVEFUVVNfUEVORElORxABEhsKF1JFUVVFU1RfU1RBVFVTX0FQUFJPVkVEEAISGwoXUkVR'
    'VUVTVF9TVEFUVVNfUkVKRUNURUQQAw==');

@$core.Deprecated('Use inviteTokenDescriptor instead')
const InviteToken$json = {
  '1': 'InviteToken',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {
      '1': 'purpose',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.TokenPurpose',
      '10': 'purpose'
    },
    {'1': 'associated_id', '3': 3, '4': 1, '5': 9, '10': 'associatedId'},
    {
      '1': 'expires_at',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
    {'1': 'is_used', '3': 5, '4': 1, '5': 8, '10': 'isUsed'},
  ],
};

/// Descriptor for `InviteToken`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteTokenDescriptor = $convert.base64Decode(
    'CgtJbnZpdGVUb2tlbhIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SLwoHcHVycG9zZRgCIAEoDjIVLm'
    'F1dGgudjEuVG9rZW5QdXJwb3NlUgdwdXJwb3NlEiMKDWFzc29jaWF0ZWRfaWQYAyABKAlSDGFz'
    'c29jaWF0ZWRJZBI5CgpleHBpcmVzX2F0GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcFIJZXhwaXJlc0F0EhcKB2lzX3VzZWQYBSABKAhSBmlzVXNlZA==');

@$core.Deprecated('Use generateInviteTokenRequestDescriptor instead')
const GenerateInviteTokenRequest$json = {
  '1': 'GenerateInviteTokenRequest',
  '2': [
    {
      '1': 'purpose',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.TokenPurpose',
      '10': 'purpose'
    },
    {'1': 'associated_id', '3': 2, '4': 1, '5': 9, '10': 'associatedId'},
    {'1': 'lifetime_seconds', '3': 3, '4': 1, '5': 3, '10': 'lifetimeSeconds'},
  ],
};

/// Descriptor for `GenerateInviteTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateInviteTokenRequestDescriptor =
    $convert.base64Decode(
        'ChpHZW5lcmF0ZUludml0ZVRva2VuUmVxdWVzdBIvCgdwdXJwb3NlGAEgASgOMhUuYXV0aC52MS'
        '5Ub2tlblB1cnBvc2VSB3B1cnBvc2USIwoNYXNzb2NpYXRlZF9pZBgCIAEoCVIMYXNzb2NpYXRl'
        'ZElkEikKEGxpZmV0aW1lX3NlY29uZHMYAyABKANSD2xpZmV0aW1lU2Vjb25kcw==');

@$core.Deprecated('Use validateInviteTokenRequestDescriptor instead')
const ValidateInviteTokenRequest$json = {
  '1': 'ValidateInviteTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `ValidateInviteTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInviteTokenRequestDescriptor =
    $convert.base64Decode(
        'ChpWYWxpZGF0ZUludml0ZVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use validateInviteTokenResponseDescriptor instead')
const ValidateInviteTokenResponse$json = {
  '1': 'ValidateInviteTokenResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '10': 'isValid'},
    {
      '1': 'purpose',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.TokenPurpose',
      '10': 'purpose'
    },
    {'1': 'associated_id', '3': 3, '4': 1, '5': 9, '10': 'associatedId'},
  ],
};

/// Descriptor for `ValidateInviteTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validateInviteTokenResponseDescriptor =
    $convert.base64Decode(
        'ChtWYWxpZGF0ZUludml0ZVRva2VuUmVzcG9uc2USGQoIaXNfdmFsaWQYASABKAhSB2lzVmFsaW'
        'QSLwoHcHVycG9zZRgCIAEoDjIVLmF1dGgudjEuVG9rZW5QdXJwb3NlUgdwdXJwb3NlEiMKDWFz'
        'c29jaWF0ZWRfaWQYAyABKAlSDGFzc29jaWF0ZWRJZA==');

@$core.Deprecated('Use requestAdminAccessRequestDescriptor instead')
const RequestAdminAccessRequest$json = {
  '1': 'RequestAdminAccessRequest',
  '2': [
    {'1': 'invitation_token', '3': 1, '4': 1, '5': 9, '10': 'invitationToken'},
    {'1': 'requested_role', '3': 2, '4': 1, '5': 9, '10': 'requestedRole'},
    {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `RequestAdminAccessRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestAdminAccessRequestDescriptor = $convert.base64Decode(
    'ChlSZXF1ZXN0QWRtaW5BY2Nlc3NSZXF1ZXN0EikKEGludml0YXRpb25fdG9rZW4YASABKAlSD2'
    'ludml0YXRpb25Ub2tlbhIlCg5yZXF1ZXN0ZWRfcm9sZRgCIAEoCVINcmVxdWVzdGVkUm9sZRIW'
    'CgZyZWFzb24YAyABKAlSBnJlYXNvbg==');

@$core.Deprecated('Use adminAccessRequestDescriptor instead')
const AdminAccessRequest$json = {
  '1': 'AdminAccessRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'requested_role', '3': 3, '4': 1, '5': 9, '10': 'requestedRole'},
    {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.RequestStatus',
      '10': 'status'
    },
    {'1': 'reason', '3': 5, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'reviewed_by', '3': 6, '4': 1, '5': 9, '10': 'reviewedBy'},
    {
      '1': 'updated_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
    {
      '1': 'user_profile',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.common.v1.UserProfile',
      '10': 'userProfile'
    },
  ],
};

/// Descriptor for `AdminAccessRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adminAccessRequestDescriptor = $convert.base64Decode(
    'ChJBZG1pbkFjY2Vzc1JlcXVlc3QSDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBn'
    'VzZXJJZBIlCg5yZXF1ZXN0ZWRfcm9sZRgDIAEoCVINcmVxdWVzdGVkUm9sZRIuCgZzdGF0dXMY'
    'BCABKA4yFi5hdXRoLnYxLlJlcXVlc3RTdGF0dXNSBnN0YXR1cxIWCgZyZWFzb24YBSABKAlSBn'
    'JlYXNvbhIfCgtyZXZpZXdlZF9ieRgGIAEoCVIKcmV2aWV3ZWRCeRI5Cgp1cGRhdGVkX2F0GAcg'
    'ASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJdXBkYXRlZEF0EjkKDHVzZXJfcHJvZm'
    'lsZRgIIAEoCzIWLmNvbW1vbi52MS5Vc2VyUHJvZmlsZVILdXNlclByb2ZpbGU=');

@$core.Deprecated('Use listAdminRequestsRequestDescriptor instead')
const ListAdminRequestsRequest$json = {
  '1': 'ListAdminRequestsRequest',
  '2': [
    {
      '1': 'filter_status',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.RequestStatus',
      '10': 'filterStatus'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.common.v1.PaginatedRequest',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListAdminRequestsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAdminRequestsRequestDescriptor = $convert.base64Decode(
    'ChhMaXN0QWRtaW5SZXF1ZXN0c1JlcXVlc3QSOwoNZmlsdGVyX3N0YXR1cxgBIAEoDjIWLmF1dG'
    'gudjEuUmVxdWVzdFN0YXR1c1IMZmlsdGVyU3RhdHVzEjsKCnBhZ2luYXRpb24YAiABKAsyGy5j'
    'b21tb24udjEuUGFnaW5hdGVkUmVxdWVzdFIKcGFnaW5hdGlvbg==');

@$core.Deprecated('Use listAdminRequestsResponseDescriptor instead')
const ListAdminRequestsResponse$json = {
  '1': 'ListAdminRequestsResponse',
  '2': [
    {
      '1': 'requests',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.auth.v1.AdminAccessRequest',
      '10': 'requests'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.common.v1.PaginatedResponse',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListAdminRequestsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAdminRequestsResponseDescriptor = $convert.base64Decode(
    'ChlMaXN0QWRtaW5SZXF1ZXN0c1Jlc3BvbnNlEjcKCHJlcXVlc3RzGAEgAygLMhsuYXV0aC52MS'
    '5BZG1pbkFjY2Vzc1JlcXVlc3RSCHJlcXVlc3RzEjwKCnBhZ2luYXRpb24YAiABKAsyHC5jb21t'
    'b24udjEuUGFnaW5hdGVkUmVzcG9uc2VSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use reviewAdminRequestRequestDescriptor instead')
const ReviewAdminRequestRequest$json = {
  '1': 'ReviewAdminRequestRequest',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 9, '10': 'requestId'},
    {
      '1': 'decision',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.auth.v1.RequestStatus',
      '10': 'decision'
    },
  ],
};

/// Descriptor for `ReviewAdminRequestRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reviewAdminRequestRequestDescriptor = $convert.base64Decode(
    'ChlSZXZpZXdBZG1pblJlcXVlc3RSZXF1ZXN0Eh0KCnJlcXVlc3RfaWQYASABKAlSCXJlcXVlc3'
    'RJZBIyCghkZWNpc2lvbhgCIAEoDjIWLmF1dGgudjEuUmVxdWVzdFN0YXR1c1IIZGVjaXNpb24=');

@$core.Deprecated('Use syncUserProfileRequestDescriptor instead')
const SyncUserProfileRequest$json = {
  '1': 'SyncUserProfileRequest',
  '2': [
    {'1': 'display_name', '3': 1, '4': 1, '5': 9, '10': 'displayName'},
    {'1': 'photo_url', '3': 2, '4': 1, '5': 9, '10': 'photoUrl'},
  ],
};

/// Descriptor for `SyncUserProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncUserProfileRequestDescriptor =
    $convert.base64Decode(
        'ChZTeW5jVXNlclByb2ZpbGVSZXF1ZXN0EiEKDGRpc3BsYXlfbmFtZRgBIAEoCVILZGlzcGxheU'
        '5hbWUSGwoJcGhvdG9fdXJsGAIgASgJUghwaG90b1VybA==');
