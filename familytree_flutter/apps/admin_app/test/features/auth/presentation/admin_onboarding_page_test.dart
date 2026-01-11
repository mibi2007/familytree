import 'dart:async';

import 'package:admin_app/features/auth/presentation/admin_onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:protobuf/well_known_types/google/protobuf/empty.pb.dart';
import 'package:shared_package/infrastructure/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';

// Mocks
class MockAuthServiceClient extends Mock implements auth_proto.AuthServiceClient {}

// ignore: must_be_immutable
class MockAuthController extends Mock implements AuthController {}

class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;
  FakeResponseFuture.value(T value) : _future = Future.value(value);
  FakeResponseFuture.error(Object error) : _future = Future.error(error);

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
  late MockAuthServiceClient mockAuthClient;
  // ignore: unused_local_variable
  late MockAuthController mockAuthController;

  setUp(() {
    mockAuthClient = MockAuthServiceClient();
    mockAuthController = MockAuthController();
    registerFallbackValue(auth_proto.RequestAdminAccessRequest());
    registerFallbackValue(Empty());
  });

  Widget createWidgetUnderTest(auth_proto.AuthStatusResponse status) {
    return ProviderScope(
      overrides: [authClientProvider.overrideWithValue(mockAuthClient)],
      child: MaterialApp(home: AdminOnboardingPage(status: status)),
    );
  }

  testWidgets('AdminOnboardingPage shows pending view when status is PENDING', (tester) async {
    // Arrange
    final status = auth_proto.AuthStatusResponse(
      isSuperAdmin: false,
      pendingRequestStatus: auth_proto.RequestStatus.REQUEST_STATUS_PENDING,
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest(status));
    await tester.pump();

    // Assert
    expect(find.text('Access Pending'), findsOneWidget);
    expect(find.text('Your request is currently under review.'), findsOneWidget);
    expect(find.text('Sign Out'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
  });

  testWidgets('AdminOnboardingPage shows entry form when status is UNSPECIFIED', (tester) async {
    // Arrange
    final status = auth_proto.AuthStatusResponse(
      isSuperAdmin: false,
      pendingRequestStatus: auth_proto.RequestStatus.REQUEST_STATUS_UNSPECIFIED,
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest(status));
    await tester.pump();

    // Assert
    expect(find.text('Admin Verification'), findsOneWidget);
    expect(find.text('Invite Token'), findsOneWidget);
    expect(find.text('Reason for Access'), findsOneWidget);
    expect(find.text('Submit Request'), findsOneWidget);
  });

  testWidgets('AdminOnboardingPage shows rejected message when status is REJECTED', (tester) async {
    // Arrange
    final status = auth_proto.AuthStatusResponse(
      isSuperAdmin: false,
      pendingRequestStatus: auth_proto.RequestStatus.REQUEST_STATUS_REJECTED,
    );

    // Act
    await tester.pumpWidget(createWidgetUnderTest(status));
    await tester.pump();

    // Assert
    expect(find.text('Admin Verification'), findsOneWidget);
    expect(find.text('Your previous request was rejected. You may submit a new one.'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Submitting form calls RequestAdminAccess', (tester) async {
    // Arrange
    final status = auth_proto.AuthStatusResponse(
      isSuperAdmin: false,
      pendingRequestStatus: auth_proto.RequestStatus.REQUEST_STATUS_UNSPECIFIED,
    );

    when(
      () => mockAuthClient.requestAdminAccess(any()),
    ).thenAnswer((_) => FakeResponseFuture.value(auth_proto.AdminAccessRequest()));

    // Act
    await tester.pumpWidget(createWidgetUnderTest(status));
    await tester.pump();

    await tester.enterText(find.widgetWithText(TextField, 'Invite Token'), 'token-123');
    await tester.enterText(find.widgetWithText(TextField, 'Reason for Access'), 'I need access');
    await tester.tap(find.text('Submit Request'));
    await tester.pump();

    // Assert
    verify(
      () => mockAuthClient.requestAdminAccess(
        any(
          that: isA<auth_proto.RequestAdminAccessRequest>()
              .having((r) => r.invitationToken, 'token', 'token-123')
              .having((r) => r.reason, 'reason', 'I need access'),
        ),
      ),
    ).called(1);
  });
}
