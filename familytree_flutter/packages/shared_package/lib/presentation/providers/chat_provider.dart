import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/infrastructure/grpc/generated/proto/chat/v1/chat.pbgrpc.dart' as chat_proto;
import 'package:shared_package/shared_package.dart';

part 'chat_provider.g.dart';

@riverpod
Stream<chat_proto.Message> familyChatStream(Ref ref, String familyId) async* {
  final client = ref.read(chatClientProvider);
  final stream = client.streamMessages(chat_proto.StreamMessagesRequest(familyId: familyId));

  await for (final msg in stream) {
    yield msg;
  }
}

@riverpod
Future<List<chat_proto.Message>> chatHistory(Ref ref, String familyId) async {
  final client = ref.read(chatClientProvider);
  final response = await client.listMessages(chat_proto.ListMessagesRequest(familyId: familyId, limit: 50));
  return response.messages;
}

@riverpod
class MergedChatMessages extends _$MergedChatMessages {
  @override
  FutureOr<List<chat_proto.Message>> build(String familyId) async {
    final history = await ref.watch(chatHistoryProvider(familyId).future);
    final messages = [...history];

    ref.listen(familyChatStreamProvider(familyId), (previous, next) {
      next.whenData((newMsg) {
        // Check if message is already in list (e.g. if we sent it and it came back via stream)
        if (!messages.any((m) => m.id == newMsg.id)) {
          messages.insert(0, newMsg);
          state = AsyncData(List.unmodifiable(messages));
        }
      });
    });

    return messages;
  }
}

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<void> build() {}

  Future<void> sendMessage(String familyId, String content) async {
    final client = ref.read(chatClientProvider);
    await client.sendMessage(
      chat_proto.SendMessageRequest(
        familyId: familyId,
        content: content,
        type: chat_proto.MessageType.MESSAGE_TYPE_TEXT,
      ),
    );
    // No need to manually refresh history as the stream will provide the new message
  }
}
