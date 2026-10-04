import 'package:signals/signals.dart';

import '../../data/grpc/generated/proto/ai/v1/ai.pbgrpc.dart' as ai_proto;
import '../../data/signals/grpc_client_signals.dart';

class AIChatMessage {
  final String text;
  final bool fromUser;

  const AIChatMessage({required this.text, required this.fromUser});
}

final aiMessagesSignal = signal<List<AIChatMessage>>([]);
final aiLoadingSignal = signal(false);
final aiErrorSignal = signal<String?>(null);

bool containsFamilyMention(String text) {
  return RegExp(r'(^|\s)@family\b', caseSensitive: false).hasMatch(text);
}

Future<ai_proto.AskResponse?> askFamilyAI({
  required String familyId,
  required String actingMemberId,
  required String question,
  bool groupChat = false,
  String conversationRef = '',
}) async {
  final trimmedQuestion = question.trim();
  if (familyId.trim().isEmpty ||
      actingMemberId.trim().isEmpty ||
      trimmedQuestion.isEmpty) {
    aiErrorSignal.value = 'Family, acting member, and question are required.';
    return null;
  }

  aiLoadingSignal.value = true;
  aiErrorSignal.value = null;
  if (!groupChat) {
    aiMessagesSignal.value = [
      ...aiMessagesSignal.value,
      AIChatMessage(text: trimmedQuestion, fromUser: true),
    ];
  }

  try {
    final response = await aiClientSignal.value.ask(
      ai_proto.AskRequest(
        familyId: familyId,
        actingMemberId: actingMemberId,
        question: trimmedQuestion,
        conversationRef: conversationRef,
        groupChat: groupChat,
      ),
    );
    if (!groupChat) {
      aiMessagesSignal.value = [
        ...aiMessagesSignal.value,
        AIChatMessage(text: response.answer, fromUser: false),
      ];
    }
    return response;
  } catch (error) {
    aiErrorSignal.value = error.toString();
    return null;
  } finally {
    aiLoadingSignal.value = false;
  }
}

void clearAIChat() {
  aiMessagesSignal.value = [];
  aiErrorSignal.value = null;
  aiLoadingSignal.value = false;
}
