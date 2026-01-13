// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myFamilies)
final myFamiliesProvider = MyFamiliesProvider._();

final class MyFamiliesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<family_proto.Family>>,
          List<family_proto.Family>,
          FutureOr<List<family_proto.Family>>
        >
    with
        $FutureModifier<List<family_proto.Family>>,
        $FutureProvider<List<family_proto.Family>> {
  MyFamiliesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myFamiliesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myFamiliesHash();

  @$internal
  @override
  $FutureProviderElement<List<family_proto.Family>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<family_proto.Family>> create(Ref ref) {
    return myFamilies(ref);
  }
}

String _$myFamiliesHash() => r'15154d6578191ab29491183654b14ff5688e00e5';

@ProviderFor(familyMembers)
final familyMembersProvider = FamilyMembersFamily._();

final class FamilyMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<family_proto.Member>>,
          List<family_proto.Member>,
          FutureOr<List<family_proto.Member>>
        >
    with
        $FutureModifier<List<family_proto.Member>>,
        $FutureProvider<List<family_proto.Member>> {
  FamilyMembersProvider._({
    required FamilyMembersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'familyMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$familyMembersHash();

  @override
  String toString() {
    return r'familyMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<family_proto.Member>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<family_proto.Member>> create(Ref ref) {
    final argument = this.argument as String;
    return familyMembers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$familyMembersHash() => r'e5dddfae745eb914dc330a853e2c1f190e702189';

final class FamilyMembersFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<family_proto.Member>>, String> {
  FamilyMembersFamily._()
    : super(
        retry: null,
        name: r'familyMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FamilyMembersProvider call(String familyId) =>
      FamilyMembersProvider._(argument: familyId, from: this);

  @override
  String toString() => r'familyMembersProvider';
}

@ProviderFor(FamilyController)
final familyControllerProvider = FamilyControllerProvider._();

final class FamilyControllerProvider
    extends $AsyncNotifierProvider<FamilyController, void> {
  FamilyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'familyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$familyControllerHash();

  @$internal
  @override
  FamilyController create() => FamilyController();
}

String _$familyControllerHash() => r'323bfd5ce17a0cd4f22b833902af410ee3bc615e';

abstract class _$FamilyController extends $AsyncNotifier<void> {
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
