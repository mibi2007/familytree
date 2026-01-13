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
    final newOptions = options.mergedWith(
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
    return invoker(method, request, newOptions);
  }

  // Handle streams if needed
}
