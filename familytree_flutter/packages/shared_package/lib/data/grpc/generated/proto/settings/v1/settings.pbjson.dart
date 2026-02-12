// This is a generated file - do not edit.
//
// Generated from proto/settings/v1/settings.proto.

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

@$core.Deprecated('Use themeModeDescriptor instead')
const ThemeMode$json = {
  '1': 'ThemeMode',
  '2': [
    {'1': 'THEME_MODE_UNSPECIFIED', '2': 0},
    {'1': 'THEME_MODE_LIGHT', '2': 1},
    {'1': 'THEME_MODE_DARK', '2': 2},
    {'1': 'THEME_MODE_SYSTEM', '2': 3},
  ],
};

/// Descriptor for `ThemeMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List themeModeDescriptor = $convert.base64Decode(
    'CglUaGVtZU1vZGUSGgoWVEhFTUVfTU9ERV9VTlNQRUNJRklFRBAAEhQKEFRIRU1FX01PREVfTE'
    'lHSFQQARITCg9USEVNRV9NT0RFX0RBUksQAhIVChFUSEVNRV9NT0RFX1NZU1RFTRAD');

@$core.Deprecated('Use languageDescriptor instead')
const Language$json = {
  '1': 'Language',
  '2': [
    {'1': 'LANGUAGE_UNSPECIFIED', '2': 0},
    {'1': 'LANGUAGE_VI', '2': 1},
    {'1': 'LANGUAGE_EN', '2': 2},
  ],
};

/// Descriptor for `Language`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List languageDescriptor = $convert.base64Decode(
    'CghMYW5ndWFnZRIYChRMQU5HVUFHRV9VTlNQRUNJRklFRBAAEg8KC0xBTkdVQUdFX1ZJEAESDw'
    'oLTEFOR1VBR0VfRU4QAg==');

@$core.Deprecated('Use userSettingsDescriptor instead')
const UserSettings$json = {
  '1': 'UserSettings',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {
      '1': 'theme_mode',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.settings.v1.ThemeMode',
      '10': 'themeMode'
    },
    {
      '1': 'language',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.settings.v1.Language',
      '10': 'language'
    },
    {
      '1': 'email_notifications_enabled',
      '3': 4,
      '4': 1,
      '5': 8,
      '10': 'emailNotificationsEnabled'
    },
    {
      '1': 'push_notifications_enabled',
      '3': 5,
      '4': 1,
      '5': 8,
      '10': 'pushNotificationsEnabled'
    },
    {
      '1': 'created_at',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'createdAt'
    },
    {
      '1': 'updated_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `UserSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSettingsDescriptor = $convert.base64Decode(
    'CgxVc2VyU2V0dGluZ3MSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEjUKCnRoZW1lX21vZGUYAi'
    'ABKA4yFi5zZXR0aW5ncy52MS5UaGVtZU1vZGVSCXRoZW1lTW9kZRIxCghsYW5ndWFnZRgDIAEo'
    'DjIVLnNldHRpbmdzLnYxLkxhbmd1YWdlUghsYW5ndWFnZRI+ChtlbWFpbF9ub3RpZmljYXRpb2'
    '5zX2VuYWJsZWQYBCABKAhSGWVtYWlsTm90aWZpY2F0aW9uc0VuYWJsZWQSPAoacHVzaF9ub3Rp'
    'ZmljYXRpb25zX2VuYWJsZWQYBSABKAhSGHB1c2hOb3RpZmljYXRpb25zRW5hYmxlZBI5Cgpjcm'
    'VhdGVkX2F0GAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJY3JlYXRlZEF0EjkK'
    'CnVwZGF0ZWRfYXQYByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgl1cGRhdGVkQX'
    'Q=');

@$core.Deprecated('Use getUserSettingsRequestDescriptor instead')
const GetUserSettingsRequest$json = {
  '1': 'GetUserSettingsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetUserSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChZHZXRVc2VyU2V0dGluZ3NSZXF1ZXN0EhcKB3VzZXJfaWQYASABKAlSBnVzZXJJZA==');

@$core.Deprecated('Use getUserSettingsResponseDescriptor instead')
const GetUserSettingsResponse$json = {
  '1': 'GetUserSettingsResponse',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.UserSettings',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `GetUserSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUserSettingsResponseDescriptor =
    $convert.base64Decode(
        'ChdHZXRVc2VyU2V0dGluZ3NSZXNwb25zZRI1CghzZXR0aW5ncxgBIAEoCzIZLnNldHRpbmdzLn'
        'YxLlVzZXJTZXR0aW5nc1IIc2V0dGluZ3M=');

@$core.Deprecated('Use updateUserSettingsRequestDescriptor instead')
const UpdateUserSettingsRequest$json = {
  '1': 'UpdateUserSettingsRequest',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.UserSettings',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `UpdateUserSettingsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserSettingsRequestDescriptor =
    $convert.base64Decode(
        'ChlVcGRhdGVVc2VyU2V0dGluZ3NSZXF1ZXN0EjUKCHNldHRpbmdzGAEgASgLMhkuc2V0dGluZ3'
        'MudjEuVXNlclNldHRpbmdzUghzZXR0aW5ncw==');

@$core.Deprecated('Use updateUserSettingsResponseDescriptor instead')
const UpdateUserSettingsResponse$json = {
  '1': 'UpdateUserSettingsResponse',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.settings.v1.UserSettings',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `UpdateUserSettingsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateUserSettingsResponseDescriptor =
    $convert.base64Decode(
        'ChpVcGRhdGVVc2VyU2V0dGluZ3NSZXNwb25zZRI1CghzZXR0aW5ncxgBIAEoCzIZLnNldHRpbm'
        'dzLnYxLlVzZXJTZXR0aW5nc1IIc2V0dGluZ3M=');
