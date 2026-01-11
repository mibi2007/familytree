import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:shared_package/infrastructure/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import 'package:shared_package/shared_package.dart';

// Mocks
class MockFamilyServiceClient extends Mock implements family_proto.FamilyServiceClient {}

class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;
  FakeResponseFuture.value(T value) : _future = Future.value(value);

  @override
  Future<S> then<S>(FutureOr<S> Function(T value) onValue, {Function? onError}) =>
      _future.then(onValue, onError: onError);

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) => _future.whenComplete(action);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Stream<T> asStream() => _future.asStream();

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});
}

void main() {
  late MockFamilyServiceClient mockFamilyClient;
  late ProviderContainer container;

  setUp(() {
    mockFamilyClient = MockFamilyServiceClient();
    container = ProviderContainer(overrides: [familyClientProvider.overrideWithValue(mockFamilyClient)]);
    registerFallbackValue(family_proto.CreateFamilyRequest());
    registerFallbackValue(family_proto.AddMemberRequest());
    registerFallbackValue(Empty());
  });

  tearDown(() {
    container.dispose();
  });

  group('FamilyController tests', () {
    test('createFamily calls gRPC and completes successfully', () async {
      final family = family_proto.Family(id: 'f1', name: 'New Family');
      when(() => mockFamilyClient.createFamily(any())).thenAnswer((_) => FakeResponseFuture.value(family));

      final result = await container.read(familyControllerProvider.notifier).createFamily('New Family');

      expect(result.id, 'f1');
      expect(result.name, 'New Family');
      verify(
        () => mockFamilyClient.createFamily(
          any(that: isA<family_proto.CreateFamilyRequest>().having((r) => r.name, 'name', 'New Family')),
        ),
      ).called(1);
    });

    test('addMember calls gRPC and invalidates familyMembersProvider', () async {
      final member = family_proto.Member(id: 'm1', displayName: 'Member 1');
      when(() => mockFamilyClient.addMember(any())).thenAnswer((_) => FakeResponseFuture.value(member));

      final result = await container
          .read(familyControllerProvider.notifier)
          .addMember(familyId: 'f1', displayName: 'Member 1');

      expect(result.id, 'm1');
      expect(result.displayName, 'Member 1');
      verify(
        () => mockFamilyClient.addMember(
          any(
            that: isA<family_proto.AddMemberRequest>()
                .having((r) => r.familyId, 'familyId', 'f1')
                .having((r) => r.displayName, 'displayName', 'Member 1'),
          ),
        ),
      ).called(1);
    });
  });

  group('myFamilies provider tests', () {
    test('fetches families successfully', () async {
      final familiesResponse = family_proto.ListMyFamiliesResponse(
        families: [family_proto.Family(id: 'f1', name: 'Family 1')],
      );
      when(() => mockFamilyClient.listMyFamilies(any())).thenAnswer((_) => FakeResponseFuture.value(familiesResponse));

      final result = await container.read(myFamiliesProvider.future);

      expect(result.length, 1);
      expect(result[0].name, 'Family 1');
    });
  });
}
