// This is a generated file - do not edit.
//
// Generated from proto/ai/v1/ai.proto.

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

@$core.Deprecated('Use askRequestDescriptor instead')
const AskRequest$json = {
  '1': 'AskRequest',
  '2': [
    {'1': 'family_id', '3': 1, '4': 1, '5': 9, '10': 'familyId'},
    {'1': 'acting_member_id', '3': 2, '4': 1, '5': 9, '10': 'actingMemberId'},
    {'1': 'question', '3': 3, '4': 1, '5': 9, '10': 'question'},
    {'1': 'conversation_ref', '3': 4, '4': 1, '5': 9, '10': 'conversationRef'},
    {'1': 'group_chat', '3': 5, '4': 1, '5': 8, '10': 'groupChat'},
  ],
};

/// Descriptor for `AskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List askRequestDescriptor = $convert.base64Decode(
    'CgpBc2tSZXF1ZXN0EhsKCWZhbWlseV9pZBgBIAEoCVIIZmFtaWx5SWQSKAoQYWN0aW5nX21lbW'
    'Jlcl9pZBgCIAEoCVIOYWN0aW5nTWVtYmVySWQSGgoIcXVlc3Rpb24YAyABKAlSCHF1ZXN0aW9u'
    'EikKEGNvbnZlcnNhdGlvbl9yZWYYBCABKAlSD2NvbnZlcnNhdGlvblJlZhIdCgpncm91cF9jaG'
    'F0GAUgASgIUglncm91cENoYXQ=');

@$core.Deprecated('Use askResponseDescriptor instead')
const AskResponse$json = {
  '1': 'AskResponse',
  '2': [
    {'1': 'answer', '3': 1, '4': 1, '5': 9, '10': 'answer'},
    {'1': 'provider', '3': 2, '4': 1, '5': 9, '10': 'provider'},
    {'1': 'final', '3': 3, '4': 1, '5': 8, '10': 'final'},
  ],
};

/// Descriptor for `AskResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List askResponseDescriptor = $convert.base64Decode(
    'CgtBc2tSZXNwb25zZRIWCgZhbnN3ZXIYASABKAlSBmFuc3dlchIaCghwcm92aWRlchgCIAEoCV'
    'IIcHJvdmlkZXISFAoFZmluYWwYAyABKAhSBWZpbmFs');
