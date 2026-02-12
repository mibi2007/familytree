import 'package:signals/signals.dart';

import '../../data/grpc/generated/proto/chat/v1/chat.pbgrpc.dart' as chat_proto;
import '../../data/signals/grpc_client_signals.dart';

// State for messages by family ID
final _messagesMap = <String, Signal<AsyncState<List<chat_proto.Message>>>>{};

/// Get signal for merged chat messages (history + real-time) for a family
Signal<AsyncState<List<chat_proto.Message>>> mergedChatMessagesSignal(String familyId) {
  if (!_messagesMap.containsKey(familyId)) {
    _messagesMap[familyId] = signal(AsyncState.loading());
  }
  return _messagesMap[familyId]!;
}

/// Load initial message history
Future<void> loadMessages(String familyId) async {
  final s = mergedChatMessagesSignal(familyId);
  try {
    final client = chatClientSignal.value;
    final response = await client.listMessages(chat_proto.ListMessagesRequest(familyId: familyId, limit: 50));
    s.value = AsyncState.data(response.messages);
  } catch (e, stack) {
    s.value = AsyncState.error(e, stack);
  }
}

/// Start streaming messages for a family
Future<void> streamMessages(String familyId) async {
  final client = chatClientSignal.value;
  final stream = client.streamMessages(chat_proto.StreamMessagesRequest(familyId: familyId));

  stream.listen(
    (message) {
      final s = mergedChatMessagesSignal(familyId);
      final current = s.value.value ?? [];

      // Add if not already present (dedup)
      if (!current.any((m) => m.id == message.id)) {
        // Prepend because we display in reverse usually, or append?
        // ChatPage uses reverse: true, so index 0 is bottom (newest).
        // If history is sorted oldest to newest, then reverse view shows newest at bottom.
        // Let's assume history comes oldest to newest.
        // Wait, standard chat list:
        // [Oldest, ..., Newest]
        // Reverse ListView: index 0 is last element of list.
        // If we want newest message to be index 0, logic depends.
        // Let's stick to simple: List contains messages sorted by time.
        // If reverse: true, then the LAST element of the list is at the BOTTOM of the screen.
        // Wait, ListView reverse: true means index 0 is at bottom.

        // Let's follow chat_provider logic:
        // messages.insert(0, newMsg);
        // This suggests the list is [Newest, ..., Oldest]

        final newList = [message, ...current];
        s.value = AsyncState.data(newList);
      }
    },
    onError: (e) {
      // Stream error, maybe show toaster but keep existing messages
      print('Chat stream error: $e');
    },
  );
}

/// Send a message
Future<void> sendMessage(String familyId, String content) async {
  final client = chatClientSignal.value;
  await client.sendMessage(
    chat_proto.SendMessageRequest(familyId: familyId, content: content, type: chat_proto.MessageType.MESSAGE_TYPE_TEXT),
  );
}
