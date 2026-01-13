// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authState)
final authStateProvider = AuthStateProvider._();

final class AuthStateProvider
    extends
        $FunctionalProvider<AsyncValue<fb.User?>, fb.User?, Stream<fb.User?>>
    with $FutureModifier<fb.User?>, $StreamProvider<fb.User?> {
  AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  $StreamProviderElement<fb.User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<fb.User?> create(Ref ref) {
    return authState(ref);
  }
}

String _$authStateHash() => r'46dda190b08536087a58ddc8fde693973fe947de';

@ProviderFor(adminStatus)
final adminStatusProvider = AdminStatusProvider._();

final class AdminStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<auth_proto.AuthStatusResponse>,
          auth_proto.AuthStatusResponse,
          FutureOr<auth_proto.AuthStatusResponse>
        >
    with
        $FutureModifier<auth_proto.AuthStatusResponse>,
        $FutureProvider<auth_proto.AuthStatusResponse> {
  AdminStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminStatusHash();

  @$internal
  @override
  $FutureProviderElement<auth_proto.AuthStatusResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<auth_proto.AuthStatusResponse> create(Ref ref) {
    return adminStatus(ref);
  }
}

String _$adminStatusHash() => r'ec9914493f9ffb30507b8686e7f26fb02b5f5cfe';

@ProviderFor(userProfile)
final userProfileProvider = UserProfileFamily._();

final class UserProfileProvider
    extends
        $FunctionalProvider<
          AsyncValue<common_proto.UserProfile>,
          common_proto.UserProfile,
          FutureOr<common_proto.UserProfile>
        >
    with
        $FutureModifier<common_proto.UserProfile>,
        $FutureProvider<common_proto.UserProfile> {
  UserProfileProvider._({
    required UserProfileFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userProfileHash();

  @override
  String toString() {
    return r'userProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<common_proto.UserProfile> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<common_proto.UserProfile> create(Ref ref) {
    final argument = this.argument as String;
    return userProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userProfileHash() => r'fe35fd9ce373c87acb05b5da7c15f4bd66a61b41';

final class UserProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<common_proto.UserProfile>, String> {
  UserProfileFamily._()
    : super(
        retry: null,
        name: r'userProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserProfileProvider call(String userId) =>
      UserProfileProvider._(argument: userId, from: this);

  @override
  String toString() => r'userProfileProvider';
}

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, void> {
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'4b88283e889f10f97283ea30a33a12cfb8dffc89';

abstract class _$AuthController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
