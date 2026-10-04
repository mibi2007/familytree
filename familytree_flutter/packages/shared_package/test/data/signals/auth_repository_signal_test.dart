import 'package:flutter_test/flutter_test.dart';
import 'package:shared_package/data/signals/auth_repository_signal.dart';

void main() {
  group('Auth Repository Signal', () {
    setUp(() {
      authRepositorySignal.value = null;
    });

    test('starts uninitialized until application bootstrap runs', () {
      expect(authRepositorySignal.value, isNull);
    });

    test('returns the same current value across reads', () {
      final authRepo1 = authRepositorySignal.value;
      final authRepo2 = authRepositorySignal.value;

      expect(identical(authRepo1, authRepo2), isTrue);
    });
  });
}
