// This is a generated file - do not edit.
//
// Generated from proto/system/v1/system.proto.

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

@$core.Deprecated('Use healthCheckRequestDescriptor instead')
const HealthCheckRequest$json = {
  '1': 'HealthCheckRequest',
};

/// Descriptor for `HealthCheckRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckRequestDescriptor =
    $convert.base64Decode('ChJIZWFsdGhDaGVja1JlcXVlc3Q=');

@$core.Deprecated('Use healthCheckResponseDescriptor instead')
const HealthCheckResponse$json = {
  '1': 'HealthCheckResponse',
  '2': [
    {'1': 'overall_status', '3': 1, '4': 1, '5': 9, '10': 'overallStatus'},
    {
      '1': 'checked_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'checkedAt'
    },
    {
      '1': 'server',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.system.v1.ComponentStatus',
      '10': 'server'
    },
    {
      '1': 'database',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.system.v1.ComponentStatus',
      '10': 'database'
    },
    {
      '1': 'storage',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.system.v1.ComponentStatus',
      '10': 'storage'
    },
  ],
};

/// Descriptor for `HealthCheckResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List healthCheckResponseDescriptor = $convert.base64Decode(
    'ChNIZWFsdGhDaGVja1Jlc3BvbnNlEiUKDm92ZXJhbGxfc3RhdHVzGAEgASgJUg1vdmVyYWxsU3'
    'RhdHVzEjkKCmNoZWNrZWRfYXQYAiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglj'
    'aGVja2VkQXQSMgoGc2VydmVyGAMgASgLMhouc3lzdGVtLnYxLkNvbXBvbmVudFN0YXR1c1IGc2'
    'VydmVyEjYKCGRhdGFiYXNlGAQgASgLMhouc3lzdGVtLnYxLkNvbXBvbmVudFN0YXR1c1IIZGF0'
    'YWJhc2USNAoHc3RvcmFnZRgFIAEoCzIaLnN5c3RlbS52MS5Db21wb25lbnRTdGF0dXNSB3N0b3'
    'JhZ2U=');

@$core.Deprecated('Use componentStatusDescriptor instead')
const ComponentStatus$json = {
  '1': 'ComponentStatus',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'response_time_ms', '3': 4, '4': 1, '5': 3, '10': 'responseTimeMs'},
  ],
};

/// Descriptor for `ComponentStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List componentStatusDescriptor = $convert.base64Decode(
    'Cg9Db21wb25lbnRTdGF0dXMSEgoEbmFtZRgBIAEoCVIEbmFtZRIWCgZzdGF0dXMYAiABKAlSBn'
    'N0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlEigKEHJlc3BvbnNlX3RpbWVfbXMYBCAB'
    'KANSDnJlc3BvbnNlVGltZU1z');
