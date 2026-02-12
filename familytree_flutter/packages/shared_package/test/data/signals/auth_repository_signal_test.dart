import 'package:flutter_test/flutter_test.dart';
import 'package:shared_package/data/repositories/firebase_auth_repository.dart';
import 'package:shared_package/data/signals/auth_repository_signal.dart';

void main() {
  group('Auth Repository Signal', () {
    test('authRepositorySignal provides FirebaseAuthRepository instance', () {
      final authRepo = authRepositorySignal.value;

      expect(authRepo, isNotNull);
      expect(authRepo, isA<FirebaseAuthRepository>());
    });

    test('authRepositorySignal returns same instance (singleton)', () {
      final authRepo1 = authRepositorySignal.value;
      final authRepo2 = authRepositorySignal.value;

      // Should be the same singleton instance
      expect(identical(authRepo1, authRepo2), isTrue);
    });
  });
}
