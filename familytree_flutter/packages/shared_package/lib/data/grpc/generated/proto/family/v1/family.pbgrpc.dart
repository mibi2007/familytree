// This is a generated file - do not edit.
//
// Generated from proto/family/v1/family.proto.

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
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart' as $1;

import 'family.pb.dart' as $0;

export 'family.pb.dart';

@$pb.GrpcServiceName('family.v1.FamilyService')
class FamilyServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  FamilyServiceClient(super.channel, {super.options, super.interceptors});

  /// Family Management
  $grpc.ResponseFuture<$0.Family> createFamily(
    $0.CreateFamilyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$createFamily, request, options: options);
  }

  $grpc.ResponseFuture<$0.Family> getFamily(
    $0.GetFamilyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamily, request, options: options);
  }

  $grpc.ResponseFuture<$0.Family> updateFamilyOwner(
    $0.UpdateFamilyOwnerRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateFamilyOwner, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> leaveFamily(
    $0.LeaveFamilyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$leaveFamily, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListMyFamiliesResponse> listMyFamilies(
    $1.Empty request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listMyFamilies, request, options: options);
  }

  /// Member Management
  $grpc.ResponseFuture<$0.Member> addMember(
    $0.AddMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$addMember, request, options: options);
  }

  $grpc.ResponseFuture<$0.Member> updateMember(
    $0.UpdateMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateMember, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteMember(
    $0.DeleteMemberRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$deleteMember, request, options: options);
  }

  /// Tree Sync
  $grpc.ResponseFuture<$0.FamilyTree> getFamilyTree(
    $0.GetFamilyTreeRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getFamilyTree, request, options: options);
  }

  $grpc.ResponseFuture<$0.Family> joinFamily(
    $0.JoinFamilyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$joinFamily, request, options: options);
  }

  // method descriptors

  static final _$createFamily =
      $grpc.ClientMethod<$0.CreateFamilyRequest, $0.Family>(
          '/family.v1.FamilyService/CreateFamily',
          ($0.CreateFamilyRequest value) => value.writeToBuffer(),
          $0.Family.fromBuffer);
  static final _$getFamily = $grpc.ClientMethod<$0.GetFamilyRequest, $0.Family>(
      '/family.v1.FamilyService/GetFamily',
      ($0.GetFamilyRequest value) => value.writeToBuffer(),
      $0.Family.fromBuffer);
  static final _$updateFamilyOwner =
      $grpc.ClientMethod<$0.UpdateFamilyOwnerRequest, $0.Family>(
          '/family.v1.FamilyService/UpdateFamilyOwner',
          ($0.UpdateFamilyOwnerRequest value) => value.writeToBuffer(),
          $0.Family.fromBuffer);
  static final _$leaveFamily =
      $grpc.ClientMethod<$0.LeaveFamilyRequest, $1.Empty>(
          '/family.v1.FamilyService/LeaveFamily',
          ($0.LeaveFamilyRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$listMyFamilies =
      $grpc.ClientMethod<$1.Empty, $0.ListMyFamiliesResponse>(
          '/family.v1.FamilyService/ListMyFamilies',
          ($1.Empty value) => value.writeToBuffer(),
          $0.ListMyFamiliesResponse.fromBuffer);
  static final _$addMember = $grpc.ClientMethod<$0.AddMemberRequest, $0.Member>(
      '/family.v1.FamilyService/AddMember',
      ($0.AddMemberRequest value) => value.writeToBuffer(),
      $0.Member.fromBuffer);
  static final _$updateMember =
      $grpc.ClientMethod<$0.UpdateMemberRequest, $0.Member>(
          '/family.v1.FamilyService/UpdateMember',
          ($0.UpdateMemberRequest value) => value.writeToBuffer(),
          $0.Member.fromBuffer);
  static final _$deleteMember =
      $grpc.ClientMethod<$0.DeleteMemberRequest, $1.Empty>(
          '/family.v1.FamilyService/DeleteMember',
          ($0.DeleteMemberRequest value) => value.writeToBuffer(),
          $1.Empty.fromBuffer);
  static final _$getFamilyTree =
      $grpc.ClientMethod<$0.GetFamilyTreeRequest, $0.FamilyTree>(
          '/family.v1.FamilyService/GetFamilyTree',
          ($0.GetFamilyTreeRequest value) => value.writeToBuffer(),
          $0.FamilyTree.fromBuffer);
  static final _$joinFamily =
      $grpc.ClientMethod<$0.JoinFamilyRequest, $0.Family>(
          '/family.v1.FamilyService/JoinFamily',
          ($0.JoinFamilyRequest value) => value.writeToBuffer(),
          $0.Family.fromBuffer);
}

@$pb.GrpcServiceName('family.v1.FamilyService')
abstract class FamilyServiceBase extends $grpc.Service {
  $core.String get $name => 'family.v1.FamilyService';

  FamilyServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateFamilyRequest, $0.Family>(
        'CreateFamily',
        createFamily_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.CreateFamilyRequest.fromBuffer(value),
        ($0.Family value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyRequest, $0.Family>(
        'GetFamily',
        getFamily_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetFamilyRequest.fromBuffer(value),
        ($0.Family value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateFamilyOwnerRequest, $0.Family>(
        'UpdateFamilyOwner',
        updateFamilyOwner_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateFamilyOwnerRequest.fromBuffer(value),
        ($0.Family value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.LeaveFamilyRequest, $1.Empty>(
        'LeaveFamily',
        leaveFamily_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.LeaveFamilyRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.ListMyFamiliesResponse>(
        'ListMyFamilies',
        listMyFamilies_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.ListMyFamiliesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AddMemberRequest, $0.Member>(
        'AddMember',
        addMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AddMemberRequest.fromBuffer(value),
        ($0.Member value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateMemberRequest, $0.Member>(
        'UpdateMember',
        updateMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateMemberRequest.fromBuffer(value),
        ($0.Member value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteMemberRequest, $1.Empty>(
        'DeleteMember',
        deleteMember_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DeleteMemberRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetFamilyTreeRequest, $0.FamilyTree>(
        'GetFamilyTree',
        getFamilyTree_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetFamilyTreeRequest.fromBuffer(value),
        ($0.FamilyTree value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JoinFamilyRequest, $0.Family>(
        'JoinFamily',
        joinFamily_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JoinFamilyRequest.fromBuffer(value),
        ($0.Family value) => value.writeToBuffer()));
  }

  $async.Future<$0.Family> createFamily_Pre($grpc.ServiceCall $call,
      $async.Future<$0.CreateFamilyRequest> $request) async {
    return createFamily($call, await $request);
  }

  $async.Future<$0.Family> createFamily(
      $grpc.ServiceCall call, $0.CreateFamilyRequest request);

  $async.Future<$0.Family> getFamily_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyRequest> $request) async {
    return getFamily($call, await $request);
  }

  $async.Future<$0.Family> getFamily(
      $grpc.ServiceCall call, $0.GetFamilyRequest request);

  $async.Future<$0.Family> updateFamilyOwner_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateFamilyOwnerRequest> $request) async {
    return updateFamilyOwner($call, await $request);
  }

  $async.Future<$0.Family> updateFamilyOwner(
      $grpc.ServiceCall call, $0.UpdateFamilyOwnerRequest request);

  $async.Future<$1.Empty> leaveFamily_Pre($grpc.ServiceCall $call,
      $async.Future<$0.LeaveFamilyRequest> $request) async {
    return leaveFamily($call, await $request);
  }

  $async.Future<$1.Empty> leaveFamily(
      $grpc.ServiceCall call, $0.LeaveFamilyRequest request);

  $async.Future<$0.ListMyFamiliesResponse> listMyFamilies_Pre(
      $grpc.ServiceCall $call, $async.Future<$1.Empty> $request) async {
    return listMyFamilies($call, await $request);
  }

  $async.Future<$0.ListMyFamiliesResponse> listMyFamilies(
      $grpc.ServiceCall call, $1.Empty request);

  $async.Future<$0.Member> addMember_Pre($grpc.ServiceCall $call,
      $async.Future<$0.AddMemberRequest> $request) async {
    return addMember($call, await $request);
  }

  $async.Future<$0.Member> addMember(
      $grpc.ServiceCall call, $0.AddMemberRequest request);

  $async.Future<$0.Member> updateMember_Pre($grpc.ServiceCall $call,
      $async.Future<$0.UpdateMemberRequest> $request) async {
    return updateMember($call, await $request);
  }

  $async.Future<$0.Member> updateMember(
      $grpc.ServiceCall call, $0.UpdateMemberRequest request);

  $async.Future<$1.Empty> deleteMember_Pre($grpc.ServiceCall $call,
      $async.Future<$0.DeleteMemberRequest> $request) async {
    return deleteMember($call, await $request);
  }

  $async.Future<$1.Empty> deleteMember(
      $grpc.ServiceCall call, $0.DeleteMemberRequest request);

  $async.Future<$0.FamilyTree> getFamilyTree_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetFamilyTreeRequest> $request) async {
    return getFamilyTree($call, await $request);
  }

  $async.Future<$0.FamilyTree> getFamilyTree(
      $grpc.ServiceCall call, $0.GetFamilyTreeRequest request);

  $async.Future<$0.Family> joinFamily_Pre($grpc.ServiceCall $call,
      $async.Future<$0.JoinFamilyRequest> $request) async {
    return joinFamily($call, await $request);
  }

  $async.Future<$0.Family> joinFamily(
      $grpc.ServiceCall call, $0.JoinFamilyRequest request);
}
