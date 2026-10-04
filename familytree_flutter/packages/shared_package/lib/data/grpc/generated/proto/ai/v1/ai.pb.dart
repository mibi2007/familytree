// This is a generated file - do not edit.
//
// Generated from proto/ai/v1/ai.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class AskRequest extends $pb.GeneratedMessage {
  factory AskRequest({
    $core.String? familyId,
    $core.String? actingMemberId,
    $core.String? question,
    $core.String? conversationRef,
    $core.bool? groupChat,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (actingMemberId != null) result.actingMemberId = actingMemberId;
    if (question != null) result.question = question;
    if (conversationRef != null) result.conversationRef = conversationRef;
    if (groupChat != null) result.groupChat = groupChat;
    return result;
  }

  AskRequest._();

  factory AskRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AskRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AskRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'ai.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'actingMemberId')
    ..aOS(3, _omitFieldNames ? '' : 'question')
    ..aOS(4, _omitFieldNames ? '' : 'conversationRef')
    ..aOB(5, _omitFieldNames ? '' : 'groupChat')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskRequest copyWith(void Function(AskRequest) updates) =>
      super.copyWith((message) => updates(message as AskRequest)) as AskRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AskRequest create() => AskRequest._();
  @$core.override
  AskRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AskRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AskRequest>(create);
  static AskRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get actingMemberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set actingMemberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActingMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearActingMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get question => $_getSZ(2);
  @$pb.TagNumber(3)
  set question($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuestion() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuestion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get conversationRef => $_getSZ(3);
  @$pb.TagNumber(4)
  set conversationRef($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConversationRef() => $_has(3);
  @$pb.TagNumber(4)
  void clearConversationRef() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get groupChat => $_getBF(4);
  @$pb.TagNumber(5)
  set groupChat($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGroupChat() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupChat() => $_clearField(5);
}

class AskResponse extends $pb.GeneratedMessage {
  factory AskResponse({
    $core.String? answer,
    $core.String? provider,
    $core.bool? final_3,
  }) {
    final result = create();
    if (answer != null) result.answer = answer;
    if (provider != null) result.provider = provider;
    if (final_3 != null) result.final_3 = final_3;
    return result;
  }

  AskResponse._();

  factory AskResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AskResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AskResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'ai.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'answer')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOB(3, _omitFieldNames ? '' : 'final')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AskResponse copyWith(void Function(AskResponse) updates) =>
      super.copyWith((message) => updates(message as AskResponse))
          as AskResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AskResponse create() => AskResponse._();
  @$core.override
  AskResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AskResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AskResponse>(create);
  static AskResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get answer => $_getSZ(0);
  @$pb.TagNumber(1)
  set answer($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAnswer() => $_has(0);
  @$pb.TagNumber(1)
  void clearAnswer() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get final_3 => $_getBF(2);
  @$pb.TagNumber(3)
  set final_3($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFinal_3() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinal_3() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
