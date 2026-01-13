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

import 'package:protobuf/protobuf.dart' as $pb;

class TokenPurpose extends $pb.ProtobufEnum {
  static const TokenPurpose TOKEN_PURPOSE_UNSPECIFIED =
      TokenPurpose._(0, _omitEnumNames ? '' : 'TOKEN_PURPOSE_UNSPECIFIED');
  static const TokenPurpose TOKEN_PURPOSE_ADMIN_ONBOARDING =
      TokenPurpose._(1, _omitEnumNames ? '' : 'TOKEN_PURPOSE_ADMIN_ONBOARDING');
  static const TokenPurpose TOKEN_PURPOSE_FAMILY_INVITE =
      TokenPurpose._(2, _omitEnumNames ? '' : 'TOKEN_PURPOSE_FAMILY_INVITE');
  static const TokenPurpose TOKEN_PURPOSE_SUPPORT_GRANT =
      TokenPurpose._(3, _omitEnumNames ? '' : 'TOKEN_PURPOSE_SUPPORT_GRANT');

  static const $core.List<TokenPurpose> values = <TokenPurpose>[
    TOKEN_PURPOSE_UNSPECIFIED,
    TOKEN_PURPOSE_ADMIN_ONBOARDING,
    TOKEN_PURPOSE_FAMILY_INVITE,
    TOKEN_PURPOSE_SUPPORT_GRANT,
  ];

  static final $core.List<TokenPurpose?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TokenPurpose? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TokenPurpose._(super.value, super.name);
}

class RequestStatus extends $pb.ProtobufEnum {
  static const RequestStatus REQUEST_STATUS_UNSPECIFIED =
      RequestStatus._(0, _omitEnumNames ? '' : 'REQUEST_STATUS_UNSPECIFIED');
  static const RequestStatus REQUEST_STATUS_PENDING =
      RequestStatus._(1, _omitEnumNames ? '' : 'REQUEST_STATUS_PENDING');
  static const RequestStatus REQUEST_STATUS_APPROVED =
      RequestStatus._(2, _omitEnumNames ? '' : 'REQUEST_STATUS_APPROVED');
  static const RequestStatus REQUEST_STATUS_REJECTED =
      RequestStatus._(3, _omitEnumNames ? '' : 'REQUEST_STATUS_REJECTED');

  static const $core.List<RequestStatus> values = <RequestStatus>[
    REQUEST_STATUS_UNSPECIFIED,
    REQUEST_STATUS_PENDING,
    REQUEST_STATUS_APPROVED,
    REQUEST_STATUS_REJECTED,
  ];

  static final $core.List<RequestStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static RequestStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const RequestStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
