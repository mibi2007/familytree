// This is a generated file - do not edit.
//
// Generated from proto/ai/v1/ai.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'ai.pb.dart' as $0;

export 'ai.pb.dart';

@$pb.GrpcServiceName('ai.v1.AIService')
class AIServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AIServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.AskResponse> ask(
    $0.AskRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$ask, request, options: options);
  }

  $grpc.ResponseStream<$0.AskResponse> askStream(
    $0.AskRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$askStream, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$ask = $grpc.ClientMethod<$0.AskRequest, $0.AskResponse>(
      '/ai.v1.AIService/Ask',
      ($0.AskRequest value) => value.writeToBuffer(),
      $0.AskResponse.fromBuffer);
  static final _$askStream = $grpc.ClientMethod<$0.AskRequest, $0.AskResponse>(
      '/ai.v1.AIService/AskStream',
      ($0.AskRequest value) => value.writeToBuffer(),
      $0.AskResponse.fromBuffer);
}

@$pb.GrpcServiceName('ai.v1.AIService')
abstract class AIServiceBase extends $grpc.Service {
  $core.String get $name => 'ai.v1.AIService';

  AIServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.AskRequest, $0.AskResponse>(
        'Ask',
        ask_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AskRequest.fromBuffer(value),
        ($0.AskResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AskRequest, $0.AskResponse>(
        'AskStream',
        askStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.AskRequest.fromBuffer(value),
        ($0.AskResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.AskResponse> ask_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AskRequest> $request) async {
    return ask($call, await $request);
  }

  $async.Future<$0.AskResponse> ask(
      $grpc.ServiceCall call, $0.AskRequest request);

  $async.Stream<$0.AskResponse> askStream_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.AskRequest> $request) async* {
    yield* askStream($call, await $request);
  }

  $async.Stream<$0.AskResponse> askStream(
      $grpc.ServiceCall call, $0.AskRequest request);
}
