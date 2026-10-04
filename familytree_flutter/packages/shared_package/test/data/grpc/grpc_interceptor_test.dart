import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_package/data/grpc/grpc_interceptor.dart';
import 'package:shared_package/domain/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockResponseStream extends Mock implements ResponseStream<int> {}

void main() {
  test('adds authorization metadata to streaming calls', () async {
    final authRepository = MockAuthRepository();
    final interceptor = GrpcAuthInterceptor(authRepository);
    final response = MockResponseStream();

    when(
      () => authRepository.getIdToken(),
    ).thenAnswer((_) async => 'test-token');

    final method = ClientMethod<int, int>(
      '/test.Service/Stream',
      (_) => const [],
      (_) => 0,
    );
    late CallOptions capturedOptions;

    final result = interceptor.interceptStreaming<int, int>(
      method,
      Stream.value(1),
      CallOptions(),
      (method, requests, options) {
        capturedOptions = options;
        return response;
      },
    );

    final metadata = <String, String>{};
    for (final provider in capturedOptions.metadataProviders) {
      await provider(metadata, 'https://localhost/test.Service/Stream');
    }

    expect(result, same(response));
    expect(metadata['authorization'], 'Bearer test-token');
    verify(() => authRepository.getIdToken()).called(1);
  });
}
