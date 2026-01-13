// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_requests_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pendingRequests)
final pendingRequestsProvider = PendingRequestsProvider._();

final class PendingRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<auth_proto.AdminAccessRequest>>,
          List<auth_proto.AdminAccessRequest>,
          FutureOr<List<auth_proto.AdminAccessRequest>>
        >
    with
        $FutureModifier<List<auth_proto.AdminAccessRequest>>,
        $FutureProvider<List<auth_proto.AdminAccessRequest>> {
  PendingRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<auth_proto.AdminAccessRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<auth_proto.AdminAccessRequest>> create(Ref ref) {
    return pendingRequests(ref);
  }
}

String _$pendingRequestsHash() => r'00f07ad49733ab61b5317721cb93a1efb5523450';

@ProviderFor(AdminRequestsController)
final adminRequestsControllerProvider = AdminRequestsControllerProvider._();

final class AdminRequestsControllerProvider
    extends $AsyncNotifierProvider<AdminRequestsController, void> {
  AdminRequestsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminRequestsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminRequestsControllerHash();

  @$internal
  @override
  AdminRequestsController create() => AdminRequestsController();
}

String _$adminRequestsControllerHash() =>
    r'891b3d9e9c5752e577d45d1f7c3fc1b0f5608077';

abstract class _$AdminRequestsController extends $AsyncNotifier<void> {
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
