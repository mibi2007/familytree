// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InviteController)
final inviteControllerProvider = InviteControllerProvider._();

final class InviteControllerProvider
    extends $AsyncNotifierProvider<InviteController, auth_proto.InviteToken?> {
  InviteControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteControllerHash();

  @$internal
  @override
  InviteController create() => InviteController();
}

String _$inviteControllerHash() => r'bdb22fb7ad0239d47bf1eced4effd99ea7194eae';

abstract class _$InviteController
    extends $AsyncNotifier<auth_proto.InviteToken?> {
  FutureOr<auth_proto.InviteToken?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<auth_proto.InviteToken?>,
              auth_proto.InviteToken?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<auth_proto.InviteToken?>,
                auth_proto.InviteToken?
              >,
              AsyncValue<auth_proto.InviteToken?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
