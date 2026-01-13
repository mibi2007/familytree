// This is a generated file - do not edit.
//
// Generated from proto/system/v1/system.proto.

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

import 'system.pb.dart' as $0;

export 'system.pb.dart';

@$pb.GrpcServiceName('system.v1.SystemService')
class SystemServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SystemServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.HealthCheckResponse> getHealthStatus(
    $0.HealthCheckRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getHealthStatus, request, options: options);
  }

  // method descriptors

  static final _$getHealthStatus =
      $grpc.ClientMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
          '/system.v1.SystemService/GetHealthStatus',
          ($0.HealthCheckRequest value) => value.writeToBuffer(),
          $0.HealthCheckResponse.fromBuffer);
}

@$pb.GrpcServiceName('system.v1.SystemService')
abstract class SystemServiceBase extends $grpc.Service {
  $core.String get $name => 'system.v1.SystemService';

  SystemServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.HealthCheckRequest, $0.HealthCheckResponse>(
            'GetHealthStatus',
            getHealthStatus_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.HealthCheckRequest.fromBuffer(value),
            ($0.HealthCheckResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HealthCheckResponse> getHealthStatus_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.HealthCheckRequest> $request) async {
    return getHealthStatus($call, await $request);
  }

  $async.Future<$0.HealthCheckResponse> getHealthStatus(
      $grpc.ServiceCall call, $0.HealthCheckRequest request);
}
