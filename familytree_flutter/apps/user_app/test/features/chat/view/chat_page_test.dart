import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart' as timestamp_proto;
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pbgrpc.dart' as auth_proto;
import 'package:shared_package/data/grpc/generated/proto/chat/v1/chat.pbgrpc.dart' as chat_proto;
import 'package:shared_package/data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/features/chat/view/chat_page.dart';

// Mock classes
class MockChatClient extends Mock implements chat_proto.ChatServiceClient {}

class MockAuthClient extends Mock implements auth_proto.AuthServiceClient {}

class MockAuthRepository extends Mock implements FirebaseAuthRepository {}

class MockUser extends Mock implements fb.User {
  @override
  String get uid => 'currentUser';
  @override
  String get displayName => 'Current User';
  @override
  String get email => 'current@test.com';
  @override
  String? get photoURL => '';
}

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

// Fake ResponseStream
class FakeResponseStream<T> extends Stream<T> implements ResponseStream<T> {
  final Stream<T> _stream;
  FakeResponseStream(this._stream);

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return _stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});

  // Overrides to satisfy ResponseStream interface narrowing
  @override
  ResponseFuture<T> get single => FakeResponseFuture(_stream.single);

  @override
  ResponseFuture<T> get first => FakeResponseFuture(_stream.first);

  @override
  ResponseFuture<T> get last => FakeResponseFuture(_stream.last);

  @override
  ResponseFuture<T> elementAt(int index) => FakeResponseFuture(_stream.elementAt(index));
}

void main() {
  setUpAll(() {
    registerFallbackValue(chat_proto.SendMessageRequest());
    registerFallbackValue(chat_proto.StreamMessagesRequest());
    registerFallbackValue(chat_proto.ListMessagesRequest());
  });

  group('ChatPage Widget Tests', () {
    const testFamilyId = 'family123';
    const testFamilyName = 'Test Family';

    late List<chat_proto.Message> testMessages;
    late MockChatClient mockChatClient;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockChatClient = MockChatClient();
      mockAuthRepository = MockAuthRepository();

      // Setup signals overrides
      mockChatClientSignal.value = mockChatClient;
      authRepositorySignal.value = mockAuthRepository;

      // Default auth state (not logged in)
      when(() => mockAuthRepository.authStateChanges).thenAnswer((_) => Stream.value(null));

      testMessages = [
        chat_proto.Message(
          id: 'msg1',
          familyId: testFamilyId,
          senderId: 'user1',
          content: 'Hello from user 1',
          type: chat_proto.MessageType.MESSAGE_TYPE_TEXT,
          createdAt: _createTimestamp(DateTime.now().subtract(const Duration(minutes: 5))),
        ),
        chat_proto.Message(
          id: 'msg2',
          familyId: testFamilyId,
          senderId: 'user2',
          content: 'Hi from user 2',
          type: chat_proto.MessageType.MESSAGE_TYPE_TEXT,
          createdAt: _createTimestamp(DateTime.now().subtract(const Duration(minutes: 2))),
        ),
        chat_proto.Message(
          id: 'msg3',
          familyId: testFamilyId,
          senderId: 'currentUser',
          content: 'My message',
          type: chat_proto.MessageType.MESSAGE_TYPE_TEXT,
          createdAt: _createTimestamp(DateTime.now()),
        ),
      ];

      // Reset signal
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.loading();

      // Mock stream response
      when(() => mockChatClient.streamMessages(any())).thenAnswer((_) => FakeResponseStream(const Stream.empty()));
      when(
        () => mockChatClient.listMessages(any()),
      ).thenAnswer((_) => FakeResponseFuture.value(chat_proto.ListMessagesResponse(messages: [])));
    });

    Widget createTestWidget() {
      return const MaterialApp(
        home: ChatPage(familyId: testFamilyId, familyName: testFamilyName),
      );
    }

    testWidgets('should display app bar with family name', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text('Chat: $testFamilyName'), findsOneWidget);
    });

    testWidgets('should display loading indicator when messages are loading', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.loading();

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display error message when messages fail to load', (tester) async {
      // Arrange
      final error = Exception('Failed to load messages');
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.error(error, StackTrace.empty);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.textContaining('Error:'), findsOneWidget);
      expect(find.textContaining('Failed to load messages'), findsOneWidget);
    });

    testWidgets('should display "No messages yet" when list is empty', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data([]);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.text('No messages yet.'), findsOneWidget);
    });

    testWidgets('should display all messages in the list', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      // Mock user profiles
      getUserProfileSignal('user1').value = AsyncState.data(
        common_proto.UserProfile(id: 'user1', displayName: 'User One', photoUrl: ''),
      );
      getUserProfileSignal('user2').value = AsyncState.data(
        common_proto.UserProfile(id: 'user2', displayName: 'User Two', photoUrl: ''),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Hello from user 1'), findsOneWidget);
      expect(find.text('Hi from user 2'), findsOneWidget);
      expect(find.text('My message'), findsOneWidget);
    });

    testWidgets('should display message input field and send button', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Type a message...'), findsOneWidget);
    });

    testWidgets('should send message when send button is tapped', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);
      when(() => mockChatClient.sendMessage(any())).thenAnswer((_) => FakeResponseFuture.value(chat_proto.Message()));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      const testMessage = 'Hello, this is a test message';

      // Act
      await tester.enterText(find.byType(TextField), testMessage);
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      // Assert
      verify(
        () => mockChatClient.sendMessage(
          any(
            that: predicate<chat_proto.SendMessageRequest>(
              (req) => req.familyId == testFamilyId && req.content == testMessage,
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('should clear input field after sending message', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);
      when(() => mockChatClient.sendMessage(any())).thenAnswer((_) => FakeResponseFuture.value(chat_proto.Message()));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      const testMessage = 'Test message';

      // Act
      await tester.enterText(find.byType(TextField), testMessage);
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });

    testWidgets('should not send empty messages', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      // Act
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      // Assert
      verifyNever(() => mockChatClient.sendMessage(any()));
    });

    testWidgets('should submit message when Enter is pressed', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);
      when(() => mockChatClient.sendMessage(any())).thenAnswer((_) => FakeResponseFuture.value(chat_proto.Message()));

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      const testMessage = 'Test message';

      // Act
      await tester.enterText(find.byType(TextField), testMessage);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Assert
      verify(
        () => mockChatClient.sendMessage(
          any(that: predicate<chat_proto.SendMessageRequest>((req) => req.content == testMessage)),
        ),
      ).called(1);
    });

    testWidgets('should display sender profile pictures for messages', (tester) async {
      // Arrange
      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      getUserProfileSignal('user1').value = AsyncState.data(
        common_proto.UserProfile(id: 'user1', displayName: 'User One', photoUrl: 'https://example.com/user1.jpg'),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - Should have CircleAvatar widgets for profiles
      expect(find.byType(CircleAvatar), findsWidgets);
    });

    testWidgets('should differentiate between own messages and others', (tester) async {
      // Arrange
      final mockUser = MockUser();
      when(() => mockAuthRepository.authStateChanges).thenAnswer((_) => Stream.value(mockUser));

      mergedChatMessagesSignal(testFamilyId).value = AsyncState.data(testMessages);

      authRepositorySignal.value = mockAuthRepository;

      getUserProfileSignal('user1').value = AsyncState.data(
        common_proto.UserProfile(id: 'user1', displayName: 'User One', photoUrl: ''),
      );
      getUserProfileSignal('user2').value = AsyncState.data(
        common_proto.UserProfile(id: 'user2', displayName: 'User Two', photoUrl: ''),
      );

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Assert - My message should be visible
      expect(find.text('My message'), findsOneWidget);
    });
  });
}

// Helper function to create protobuf Timestamp
timestamp_proto.Timestamp _createTimestamp(DateTime dateTime) {
  return timestamp_proto.Timestamp()
    ..seconds = Int64(dateTime.millisecondsSinceEpoch ~/ 1000)
    ..nanos = (dateTime.millisecondsSinceEpoch % 1000) * 1000000;
}
