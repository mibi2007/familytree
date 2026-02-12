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

/// Theme mode enum
class ThemeMode extends $pb.ProtobufEnum {
  static const ThemeMode THEME_MODE_UNSPECIFIED =
      ThemeMode._(0, _omitEnumNames ? '' : 'THEME_MODE_UNSPECIFIED');
  static const ThemeMode THEME_MODE_LIGHT =
      ThemeMode._(1, _omitEnumNames ? '' : 'THEME_MODE_LIGHT');
  static const ThemeMode THEME_MODE_DARK =
      ThemeMode._(2, _omitEnumNames ? '' : 'THEME_MODE_DARK');
  static const ThemeMode THEME_MODE_SYSTEM =
      ThemeMode._(3, _omitEnumNames ? '' : 'THEME_MODE_SYSTEM');

  static const $core.List<ThemeMode> values = <ThemeMode>[
    THEME_MODE_UNSPECIFIED,
    THEME_MODE_LIGHT,
    THEME_MODE_DARK,
    THEME_MODE_SYSTEM,
  ];

  static final $core.List<ThemeMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ThemeMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ThemeMode._(super.value, super.name);
}

/// Language enum
class Language extends $pb.ProtobufEnum {
  static const Language LANGUAGE_UNSPECIFIED =
      Language._(0, _omitEnumNames ? '' : 'LANGUAGE_UNSPECIFIED');
  static const Language LANGUAGE_VI =
      Language._(1, _omitEnumNames ? '' : 'LANGUAGE_VI');
  static const Language LANGUAGE_EN =
      Language._(2, _omitEnumNames ? '' : 'LANGUAGE_EN');

  static const $core.List<Language> values = <Language>[
    LANGUAGE_UNSPECIFIED,
    LANGUAGE_VI,
    LANGUAGE_EN,
  ];

  static final $core.List<Language?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Language? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Language._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
