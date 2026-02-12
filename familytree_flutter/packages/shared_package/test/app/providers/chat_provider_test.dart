import 'dart:async';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:protobuf/well_known_types/google/protobuf/timestamp.pb.dart';
import 'package:shared_package/app/providers/chat_provider.dart';
import 'package:shared_package/data/grpc/generated/proto/chat/v1/chat.pbgrpc.dart';
import 'package:shared_package/data/grpc/grpc_client.dart';

import 'chat_provider_test.mocks.dart';

@GenerateMocks([ChatServiceClient])
void main() {
  group('Chat Provider Tests', () {
    late MockChatServiceClient mockChatClient;
    late ProviderContainer container;

    setUp(() {
      mockChatClient = MockChatServiceClient();
      container = ProviderContainer(overrides: [chatClientProvider.overrideWithValue(mockChatClient)]);
    });

    tearDown(() {
      container.dispose();
    });

    group('familyChatStream', () {
      test('should stream messages from gRPC client', () async {
        // Arrange
        final familyId = 'family123';
        final messages = [
          Message(
            id: 'msg1',
            familyId: familyId,
            senderId: 'user1',
            content: 'Hello',
            type: MessageType.MESSAGE_TYPE_TEXT,
            createdAt: _createTimestamp(DateTime.now()),
          ),
          Message(
            id: 'msg2',
            familyId: familyId,
            senderId: 'user2',
            content: 'Hi there',
            type: MessageType.MESSAGE_TYPE_TEXT,
            createdAt: _createTimestamp(DateTime.now()),
          ),
        ];

        when(mockChatClient.streamMessages(any)).thenAnswer((_) => FakeResponseStream(Stream.fromIterable(messages)));

        // Act
        // Verify the stream completes and yields types.
        // We use .future which completes with the last element of the stream.
        final lastMessage = await container.read(familyChatStreamProvider(familyId).future);

        // Assert
        expect(lastMessage.id, 'msg2');
      });

      test('should handle stream errors', () async {
        // Arrange
        final familyId = 'family123';
        final error = GrpcError.unavailable('Connection lost');

        when(mockChatClient.streamMessages(any)).thenAnswer((_) => FakeResponseStream(Stream.error(error)));

        // Act
        final future = container.read(familyChatStreamProvider(familyId).future);

        // Assert
        await expectLater(future, throwsA(isA<GrpcError>()));
      });
    });

    group('chatHistory', () {
      test('should fetch message history successfully', () async {
        // Arrange
        final familyId = 'family123';
        final messages = [
          Message(
            id: 'msg1',
            familyId: familyId,
            senderId: 'user1',
            content: 'Hello',
            type: MessageType.MESSAGE_TYPE_TEXT,
            createdAt: _createTimestamp(DateTime.now()),
          ),
        ];

        when(
          mockChatClient.listMessages(any),
        ).thenAnswer((_) => FakeResponseFuture.value(ListMessagesResponse(messages: messages)));

        // Act
        final result = await container.read(chatHistoryProvider(familyId).future);

        // Assert
        expect(result, isA<List<Message>>());
        expect(result.length, 1);
        expect(result.first.id, 'msg1');
        verify(mockChatClient.listMessages(any)).called(1);
      });

      test('should handle empty message history', () async {
        // Arrange
        final familyId = 'family123';

        when(
          mockChatClient.listMessages(any),
        ).thenAnswer((_) => FakeResponseFuture.value(ListMessagesResponse(messages: [])));

        // Act
        final result = await container.read(chatHistoryProvider(familyId).future);

        // Assert
        expect(result, isEmpty);
      });

      test('should throw error on failed history fetch', () async {
        // Arrange
        final familyId = 'family123';
        final error = GrpcError.notFound('Family not found');

        when(mockChatClient.listMessages(any)).thenAnswer((_) => FakeResponseFuture.error(error));

        // Act & Assert
        await expectLater(container.read(chatHistoryProvider(familyId).future), throwsA(isA<GrpcError>()));
      });
    });

    group('MergedChatMessages', () {
      test('should merge history and stream messages', () async {
        // Arrange
        final familyId = 'family123';
        final historyMessages = [
          Message(
            id: 'msg1',
            familyId: familyId,
            senderId: 'user1',
            content: 'Old message',
            type: MessageType.MESSAGE_TYPE_TEXT,
            createdAt: _createTimestamp(DateTime.now().subtract(Duration(hours: 1))),
          ),
        ];

        final streamMessages = [
          Message(
            id: 'msg2',
            familyId: familyId,
            senderId: 'user2',
            content: 'New message',
            type: MessageType.MESSAGE_TYPE_TEXT,
            createdAt: _createTimestamp(DateTime.now()),
          ),
        ];

        when(
          mockChatClient.listMessages(any),
        ).thenAnswer((_) => FakeResponseFuture.value(ListMessagesResponse(messages: historyMessages)));

        when(
          mockChatClient.streamMessages(any),
        ).thenAnswer((_) => FakeResponseStream(Stream.fromIterable(streamMessages)));

        // Act
        // Initial read triggers build
        await container.read(mergedChatMessagesProvider(familyId).future);

        // Wait for async events to settle (stream listener updates state)
        await Future.delayed(Duration.zero);

        final messages = await container.read(mergedChatMessagesProvider(familyId).future);

        // Assert
        expect(messages.length, greaterThanOrEqualTo(2));
        expect(messages.any((m) => m.id == 'msg1'), isTrue);
        expect(messages.any((m) => m.id == 'msg2'), isTrue);
      });

      test('should deduplicate messages with same ID', () async {
        // Arrange
        final familyId = 'family123';
        final duplicateMsg = Message(
          id: 'msg1',
          familyId: familyId,
          senderId: 'user1',
          content: 'Duplicate',
          type: MessageType.MESSAGE_TYPE_TEXT,
          createdAt: _createTimestamp(DateTime.now()),
        );

        when(
          mockChatClient.listMessages(any),
        ).thenAnswer((_) => FakeResponseFuture.value(ListMessagesResponse(messages: [duplicateMsg])));

        when(
          mockChatClient.streamMessages(any),
        ).thenAnswer((_) => FakeResponseStream(Stream.fromIterable([duplicateMsg])));

        // Act
        await container.read(mergedChatMessagesProvider(familyId).future);
        await Future.delayed(Duration.zero);
        final messages = await container.read(mergedChatMessagesProvider(familyId).future);

        // Assert
        expect(messages.where((m) => m.id == 'msg1').length, 1);
      });
    });

    group('ChatController', () {
      test('should send message successfully', () async {
        // Arrange
        final familyId = 'family123';
        final content = 'Test message';

        when(mockChatClient.sendMessage(any)).thenAnswer(
          (_) => FakeResponseFuture.value(
            Message(
              id: 'msg123',
              familyId: familyId,
              senderId: 'currentUser',
              content: content,
              type: MessageType.MESSAGE_TYPE_TEXT,
              createdAt: _createTimestamp(DateTime.now()),
            ),
          ),
        );

        // Act
        final controller = container.read(chatControllerProvider.notifier);
        await controller.sendMessage(familyId, content);

        // Assert
        verify(
          mockChatClient.sendMessage(
            argThat(
              predicate<SendMessageRequest>(
                (req) =>
                    req.familyId == familyId && req.content == content && req.type == MessageType.MESSAGE_TYPE_TEXT,
              ),
            ),
          ),
        ).called(1);
      });

      test('should handle send message error', () async {
        // Arrange
        final familyId = 'family123';
        final content = 'Test message';
        final error = GrpcError.permissionDenied('Not authorized');

        when(mockChatClient.sendMessage(any)).thenAnswer((_) => FakeResponseFuture.error(error));

        // Act & Assert
        final controller = container.read(chatControllerProvider.notifier);
        await expectLater(controller.sendMessage(familyId, content), throwsA(isA<GrpcError>()));
      });

      test('should not send empty messages', () async {
        final familyId = 'family123';
        final content = '';

        when(mockChatClient.sendMessage(any)).thenAnswer(
          (_) => FakeResponseFuture.value(
            Message(
              id: 'msg123',
              familyId: familyId,
              senderId: 'user',
              content: content,
              type: MessageType.MESSAGE_TYPE_TEXT,
              createdAt: _createTimestamp(DateTime.now()),
            ),
          ),
        );

        // Act
        final controller = container.read(chatControllerProvider.notifier);
        await controller.sendMessage(familyId, content);

        // Assert
        verify(mockChatClient.sendMessage(any)).called(1);
      });
    });
  });
}

Timestamp _createTimestamp(DateTime dateTime) {
  return Timestamp()
    ..seconds = Int64(dateTime.millisecondsSinceEpoch ~/ 1000)
    ..nanos = (dateTime.millisecondsSinceEpoch % 1000) * 1000000;
}

// ----------------------------------------------------------------------------
// Response Wrappers
// ----------------------------------------------------------------------------

class FakeResponseFuture<T> implements ResponseFuture<T> {
  final Future<T> _future;
  FakeResponseFuture.value(T value) : _future = Future.value(value);
  FakeResponseFuture.error(Object error) : _future = Future.error(error);

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

  @override
  Future<void> cancel() async {}

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<Map<String, String>> get trailers => Future.value({});
}

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
}
