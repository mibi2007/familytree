// This is a generated file - do not edit.
//
// Generated from proto/auth/v1/auth.proto.

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

import '../../common/v1/common.pb.dart' as $1;
import 'auth.pb.dart' as $0;

export 'auth.pb.dart';

@$pb.GrpcServiceName('auth.v1.AuthService')
class AuthServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  AuthServiceClient(super.channel, {super.options, super.interceptors});

  /// Admin Onboarding
  $grpc.ResponseFuture<$0.InviteToken> generateInviteToken(
    $0.GenerateInviteTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$generateInviteToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.ValidateInviteTokenResponse> validateInviteToken(
    $0.ValidateInviteTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$validateInviteToken, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccessRequest> requestAdminAccess(
    $0.RequestAdminAccessRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$requestAdminAccess, request, options: options);
  }

  /// Admin Approval
  $grpc.ResponseFuture<$0.ListAdminRequestsResponse> listAdminRequests(
    $0.ListAdminRequestsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listAdminRequests, request, options: options);
  }

  $grpc.ResponseFuture<$0.AdminAccessRequest> reviewAdminRequest(
    $0.ReviewAdminRequestRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$reviewAdminRequest, request, options: options);
  }

  /// Profile Management
  $grpc.ResponseFuture<$1.UserProfile> syncUserProfile(
    $0.SyncUserProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$syncUserProfile, request, options: options);
  }

  // method descriptors

  static final _$generateInviteToken =
      $grpc.ClientMethod<$0.GenerateInviteTokenRequest, $0.InviteToken>(
          '/auth.v1.AuthService/GenerateInviteToken',
          ($0.GenerateInviteTokenRequest value) => value.writeToBuffer(),
          $0.InviteToken.fromBuffer);
  static final _$validateInviteToken = $grpc.ClientMethod<
          $0.ValidateInviteTokenRequest, $0.ValidateInviteTokenResponse>(
      '/auth.v1.AuthService/ValidateInviteToken',
      ($0.ValidateInviteTokenRequest value) => value.writeToBuffer(),
      $0.ValidateInviteTokenResponse.fromBuffer);
  static final _$requestAdminAccess =
      $grpc.ClientMethod<$0.RequestAdminAccessRequest, $0.AdminAccessRequest>(
          '/auth.v1.AuthService/RequestAdminAccess',
          ($0.RequestAdminAccessRequest value) => value.writeToBuffer(),
          $0.AdminAccessRequest.fromBuffer);
  static final _$listAdminRequests = $grpc.ClientMethod<
          $0.ListAdminRequestsRequest, $0.ListAdminRequestsResponse>(
      '/auth.v1.AuthService/ListAdminRequests',
      ($0.ListAdminRequestsRequest value) => value.writeToBuffer(),
      $0.ListAdminRequestsResponse.fromBuffer);
  static final _$reviewAdminRequest =
      $grpc.ClientMethod<$0.ReviewAdminRequestRequest, $0.AdminAccessRequest>(
          '/auth.v1.AuthService/ReviewAdminRequest',
          ($0.ReviewAdminRequestRequest value) => value.writeToBuffer(),
          $0.AdminAccessRequest.fromBuffer);
  static final _$syncUserProfile =
      $grpc.ClientMethod<$0.SyncUserProfileRequest, $1.UserProfile>(
          '/auth.v1.AuthService/SyncUserProfile',
          ($0.SyncUserProfileRequest value) => value.writeToBuffer(),
          $1.UserProfile.fromBuffer);
}

@$pb.GrpcServiceName('auth.v1.AuthService')
abstract class AuthServiceBase extends $grpc.Service {
  $core.String get $name => 'auth.v1.AuthService';

  AuthServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GenerateInviteTokenRequest, $0.InviteToken>(
            'GenerateInviteToken',
            generateInviteToken_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GenerateInviteTokenRequest.fromBuffer(value),
            ($0.InviteToken value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ValidateInviteTokenRequest,
            $0.ValidateInviteTokenResponse>(
        'ValidateInviteToken',
        validateInviteToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ValidateInviteTokenRequest.fromBuffer(value),
        ($0.ValidateInviteTokenResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestAdminAccessRequest,
            $0.AdminAccessRequest>(
        'RequestAdminAccess',
        requestAdminAccess_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RequestAdminAccessRequest.fromBuffer(value),
        ($0.AdminAccessRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAdminRequestsRequest,
            $0.ListAdminRequestsResponse>(
        'ListAdminRequests',
        listAdminRequests_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListAdminRequestsRequest.fromBuffer(value),
        ($0.ListAdminRequestsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReviewAdminRequestRequest,
            $0.AdminAccessRequest>(
        'ReviewAdminRequest',
        reviewAdminRequest_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ReviewAdminRequestRequest.fromBuffer(value),
        ($0.AdminAccessRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SyncUserProfileRequest, $1.UserProfile>(
        'SyncUserProfile',
        syncUserProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SyncUserProfileRequest.fromBuffer(value),
        ($1.UserProfile value) => value.writeToBuffer()));
  }

  $async.Future<$0.InviteToken> generateInviteToken_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GenerateInviteTokenRequest> $request) async {
    return generateInviteToken($call, await $request);
  }

  $async.Future<$0.InviteToken> generateInviteToken(
      $grpc.ServiceCall call, $0.GenerateInviteTokenRequest request);

  $async.Future<$0.ValidateInviteTokenResponse> validateInviteToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ValidateInviteTokenRequest> $request) async {
    return validateInviteToken($call, await $request);
  }

  $async.Future<$0.ValidateInviteTokenResponse> validateInviteToken(
      $grpc.ServiceCall call, $0.ValidateInviteTokenRequest request);

  $async.Future<$0.AdminAccessRequest> requestAdminAccess_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RequestAdminAccessRequest> $request) async {
    return requestAdminAccess($call, await $request);
  }

  $async.Future<$0.AdminAccessRequest> requestAdminAccess(
      $grpc.ServiceCall call, $0.RequestAdminAccessRequest request);

  $async.Future<$0.ListAdminRequestsResponse> listAdminRequests_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListAdminRequestsRequest> $request) async {
    return listAdminRequests($call, await $request);
  }

  $async.Future<$0.ListAdminRequestsResponse> listAdminRequests(
      $grpc.ServiceCall call, $0.ListAdminRequestsRequest request);

  $async.Future<$0.AdminAccessRequest> reviewAdminRequest_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ReviewAdminRequestRequest> $request) async {
    return reviewAdminRequest($call, await $request);
  }

  $async.Future<$0.AdminAccessRequest> reviewAdminRequest(
      $grpc.ServiceCall call, $0.ReviewAdminRequestRequest request);

  $async.Future<$1.UserProfile> syncUserProfile_Pre($grpc.ServiceCall $call,
      $async.Future<$0.SyncUserProfileRequest> $request) async {
    return syncUserProfile($call, await $request);
  }

  $async.Future<$1.UserProfile> syncUserProfile(
      $grpc.ServiceCall call, $0.SyncUserProfileRequest request);
}
