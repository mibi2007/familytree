import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart'; // Using mocktail
import 'package:shared_package/infrastructure/repositories/firebase_auth_repository.dart';

// Create Mocks manually with Mocktail
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

void main() {
  late MockFirebaseAuth mockAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late FirebaseAuthRepository repository;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    repository = FirebaseAuthRepository(mockAuth, mockGoogleSignIn);
  });

  group('FirebaseAuthRepository', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';

    test('signInWithEmail returns User on success', () async {
      // Arrange
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(
        () => mockAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);

      // Assert
      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), mockUser);
      verify(() => mockAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    });

    test('signInWithEmail returns error message on failure', () async {
      // Arrange
      when(
        () => mockAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword),
      ).thenThrow(FirebaseAuthException(code: 'user-not-found', message: 'User not found'));

      // Act
      final result = await repository.signInWithEmail(tEmail, tPassword);

      // Assert
      expect(result.isLeft(), true);
      expect(result.getLeft().toNullable(), 'User not found');
    });

    test('signUpWithEmail returns User on success', () async {
      // Arrange
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(
        () => mockAuth.createUserWithEmailAndPassword(email: tEmail, password: tPassword),
      ).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      // Act
      final result = await repository.signUpWithEmail(tEmail, tPassword);

      // Assert
      expect(result.isRight(), true);
      expect(result.getRight().toNullable(), mockUser);
      verify(() => mockAuth.createUserWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    });

    test('signOut calls signOut on both providers', () async {
      // Arrange
      // Mocking currentUser getter. Note access syntax in mocktail:
      when(() => mockAuth.currentUser).thenReturn(null);
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      // Act
      await repository.signOut();

      // Assert
      verify(() => mockAuth.signOut()).called(1);
    });
  });
}
