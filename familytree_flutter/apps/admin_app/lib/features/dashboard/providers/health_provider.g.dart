// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthStatus)
final healthStatusProvider = HealthStatusProvider._();

final class HealthStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<HealthCheckResponse>,
          HealthCheckResponse,
          FutureOr<HealthCheckResponse>
        >
    with
        $FutureModifier<HealthCheckResponse>,
        $FutureProvider<HealthCheckResponse> {
  HealthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthStatusHash();

  @$internal
  @override
  $FutureProviderElement<HealthCheckResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HealthCheckResponse> create(Ref ref) {
    return healthStatus(ref);
  }
}

String _$healthStatusHash() => r'898417fa5a02d9cc28488fa152249efaefd56add';
