// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grpc_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(grpcChannel)
final grpcChannelProvider = GrpcChannelProvider._();

final class GrpcChannelProvider
    extends $FunctionalProvider<ClientChannel, ClientChannel, ClientChannel>
    with $Provider<ClientChannel> {
  GrpcChannelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'grpcChannelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$grpcChannelHash();

  @$internal
  @override
  $ProviderElement<ClientChannel> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClientChannel create(Ref ref) {
    return grpcChannel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClientChannel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClientChannel>(value),
    );
  }
}

String _$grpcChannelHash() => r'cefb7040a5e44a361674902612c8df8a6273ba21';

@ProviderFor(authClient)
final authClientProvider = AuthClientProvider._();

final class AuthClientProvider
    extends
        $FunctionalProvider<
          AuthServiceClient,
          AuthServiceClient,
          AuthServiceClient
        >
    with $Provider<AuthServiceClient> {
  AuthClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authClientHash();

  @$internal
  @override
  $ProviderElement<AuthServiceClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthServiceClient create(Ref ref) {
    return authClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthServiceClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthServiceClient>(value),
    );
  }
}

String _$authClientHash() => r'edae531efc8af325ca7c1ca190df51004b4e6f6f';

@ProviderFor(familyClient)
final familyClientProvider = FamilyClientProvider._();

final class FamilyClientProvider
    extends
        $FunctionalProvider<
          FamilyServiceClient,
          FamilyServiceClient,
          FamilyServiceClient
        >
    with $Provider<FamilyServiceClient> {
  FamilyClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyClientHash();

  @$internal
  @override
  $ProviderElement<FamilyServiceClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FamilyServiceClient create(Ref ref) {
    return familyClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FamilyServiceClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FamilyServiceClient>(value),
    );
  }
}

String _$familyClientHash() => r'18a12001c91d15526785d0fb5255e372b5f7fe56';
