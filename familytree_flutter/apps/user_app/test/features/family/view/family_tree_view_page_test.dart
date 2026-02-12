import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/features/family/view/family_tree_view_page.dart';

// Mock classes
class MockFamilyClient extends Mock implements family_proto.FamilyServiceClient {}

// Fake ResponseFuture
class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;
  FakeResponseFuture(this._future);

  FakeResponseFuture.value(T value) : _future = Future.value(value);

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});

  @override
  Stream<T> asStream() => _future.asStream();

  @override
  Future<T> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<S> then<S>(FutureOr<S> Function(T value) onValue, {Function? onError}) =>
      _future.then(onValue, onError: onError);

  @override
  Future<T> whenComplete(FutureOr<void> Function() action) => _future.whenComplete(action);

  @override
  Future<T> timeout(Duration timeLimit, {FutureOr<T> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);
}

void main() {
  setUpAll(() {
    registerFallbackValue(family_proto.AddMemberRequest());
    registerFallbackValue(family_proto.GetFamilyTreeRequest());
    registerFallbackValue(family_proto.CreateInviteTokenRequest());
  });

  group('FamilyTreeViewPage Widget Tests', () {
    const testFamilyId = 'family123';
    const testFamilyName = 'Test Family';

    late List<family_proto.Member> testMembers;
    late MockFamilyClient mockFamilyClient;

    setUp(() {
      mockFamilyClient = MockFamilyClient();
      mockFamilyClientSignal.value = mockFamilyClient;

      testMembers = [
        family_proto.Member(
          id: 'member1',
          familyId: testFamilyId,
          displayName: 'John Doe',
          level: 0,
          parentId: '',
          spouseId: '',
        ),
        family_proto.Member(
          id: 'member2',
          familyId: testFamilyId,
          displayName: 'Jane Doe',
          level: 0,
          parentId: '',
          spouseId: 'member1',
        ),
        family_proto.Member(
          id: 'member3',
          familyId: testFamilyId,
          displayName: 'Child Doe',
          level: 1,
          parentId: 'member1',
          spouseId: '',
        ),
      ];

      // Default stub for getFamilyTree
      when(
        () => mockFamilyClient.getFamilyTree(any()),
      ).thenAnswer((_) => FakeResponseFuture.value(family_proto.FamilyTree(members: testMembers)));

      // Initialize signal with data
      familyMembersSignal(testFamilyId).value = AsyncState.data(testMembers);
    });

    Widget createTestWidget() {
      return MaterialApp(
        home: FamilyTreeViewPage(familyId: testFamilyId, familyName: testFamilyName),
      );
    }

    testWidgets('should display app bar with family name', (tester) async {
      // Arrange
      familyMembersSignal(testFamilyId).value = AsyncState.data(testMembers);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text(testFamilyName), findsOneWidget);
    });

    testWidgets('should display loading indicator when members are loading', (tester) async {
      // Arrange
      familyMembersSignal(testFamilyId).value = AsyncState.loading();

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message when members fail to load', (tester) async {
      // Arrange
      final error = Exception('Failed to load family members');
      familyMembersSignal(testFamilyId).value = AsyncState.error(error, StackTrace.empty);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.textContaining('Error:'), findsOneWidget);
    });

    testWidgets('should display empty state when no members exist', (tester) async {
      // Arrange
      familyMembersSignal(testFamilyId).value = AsyncState.data([]);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.textContaining('No members found'), findsOneWidget);
      expect(find.textContaining('Add First Member'), findsOneWidget);
    });

    testWidgets('should display family tree canvas when members exist', (tester) async {
      // Arrange
      familyMembersSignal(testFamilyId).value = AsyncState.data(testMembers);

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('should show add member FAB', (tester) async {
      // Arrange
      familyMembersSignal(testFamilyId).value = AsyncState.data(testMembers);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('should show invite dialog when invite menu item is tapped', (tester) async {
      // Arrange
      when(() => mockFamilyClient.createInviteToken(any())).thenAnswer(
        (_) => FakeResponseFuture.value(family_proto.CreateInviteTokenResponse(inviteToken: 'invite-token-123')),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      // Note: Invite button is now in actions, not popup menu in new design (Icon: share)
      await tester.tap(find.byIcon(Icons.share));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Invite Member'), findsOneWidget);
      expect(find.text('invite-token-123'), findsOneWidget);
    });

    testWidgets('should show add member dialog when FAB is tapped', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Add Member'), findsOneWidget);
      expect(find.text('Display Name'), findsOneWidget);
    });

    testWidgets('should add member when form is submitted', (tester) async {
      // Arrange
      when(
        () => mockFamilyClient.addMember(any()),
      ).thenAnswer((_) => FakeResponseFuture.value(family_proto.Member(id: 'new', displayName: 'New Member')));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'New Member');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Assert
      verify(
        () => mockFamilyClient.addMember(
          any(
            that: predicate<family_proto.AddMemberRequest>(
              (req) => req.familyId == testFamilyId && req.displayName == 'New Member',
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('should not submit form with empty name', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Assert - Check that client was NOT called
      verifyNever(() => mockFamilyClient.addMember(any()));

      // Dialog should still be open
      expect(find.text('Add Member'), findsOneWidget);
    });

    testWidgets('should cancel add member dialog', (tester) async {
      // Arrange
      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.person_add));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Add Member'), findsNothing);
    });
  });
}
