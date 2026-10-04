import 'package:grpc/grpc.dart';

import '../../domain/repositories/auth_repository.dart';

class GrpcAuthInterceptor extends ClientInterceptor {
  final AuthRepository _authRepository;

  GrpcAuthInterceptor(this._authRepository);

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    return invoker(method, request, _withAuth(options));
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    return invoker(method, requests, _withAuth(options));
  }

  CallOptions _withAuth(CallOptions options) {
    return options.mergedWith(
      CallOptions(
        providers: [
          (metadata, uri) async {
            final token = await _authRepository.getIdToken();
            if (token != null) {
              metadata['authorization'] = 'Bearer $token';
            }
          },
        ],
      ),
    );
  }
}
