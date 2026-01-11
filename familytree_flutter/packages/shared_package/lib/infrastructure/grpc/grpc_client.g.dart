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

String _$grpcChannelHash() => r'efd29d7679515a7bf1f6286a85fff009ba3687a3';

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

String _$authClientHash() => r'4609901e5bddd2a4e2d7915e65d69675b5baf025';

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

String _$familyClientHash() => r'c417317238fa406508d8360c754e8139cc59fe25';

@ProviderFor(chatClient)
final chatClientProvider = ChatClientProvider._();

final class ChatClientProvider
    extends
        $FunctionalProvider<
          ChatServiceClient,
          ChatServiceClient,
          ChatServiceClient
        >
    with $Provider<ChatServiceClient> {
  ChatClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatClientHash();

  @$internal
  @override
  $ProviderElement<ChatServiceClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatServiceClient create(Ref ref) {
    return chatClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatServiceClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatServiceClient>(value),
    );
  }
}

String _$chatClientHash() => r'5028e5ed07807a8ac9767aa00b48de0fb933b672';
