import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/features/auth/view/login_page.dart';

// Mocks
class MockAuthRepository extends Mock implements FirebaseAuthRepository {}

class MockAuthServiceClient extends Mock implements auth_proto.AuthServiceClient {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockAuthServiceClient mockAuthClient;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockAuthClient = MockAuthServiceClient();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        authClientProvider.overrideWithValue(mockAuthClient),
      ],
      child: const MaterialApp(home: LoginPage()),
    );
  }

  testWidgets('LoginPage smoke test', (tester) async {
    // Act
    await tester.pumpWidget(createWidgetUnderTest());

    // Assert
    expect(find.byType(LoginPage), findsOneWidget);
    // Add more expectations if LoginPage has content
  });
}
