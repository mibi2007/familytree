import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/chat/v1/chat.pbgrpc.dart' as chat_proto;
import 'package:shared_package/shared_package.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String familyId;
  final String familyName;

  const ChatPage({super.key, required this.familyId, required this.familyName});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    ref.read(chatControllerProvider.notifier).sendMessage(widget.familyId, content);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(mergedChatMessagesProvider(widget.familyId));

    return Scaffold(
      appBar: AppBar(title: Text('Chat: ${widget.familyName}')),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                return _MessageList(messages: messages, scrollController: _scrollController);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(hintText: 'Type a message...', border: InputBorder.none),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage, color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  final List<chat_proto.Message> messages;
  final ScrollController scrollController;

  const _MessageList({required this.messages, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const Center(child: Text('No messages yet.'));
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true, // Show latest at bottom
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _MessageItem(message: message);
      },
    );
  }
}

class _MessageItem extends ConsumerWidget {
  final chat_proto.Message message;

  const _MessageItem({required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider(message.senderId));
    final isMe = ref.watch(authStateProvider).value?.uid == message.senderId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            profileAsync.when(
              data: (p) => CircleAvatar(
                backgroundImage: p.photoUrl.isNotEmpty ? NetworkImage(p.photoUrl) : null,
                child: p.photoUrl.isEmpty ? Text(p.displayName.isNotEmpty ? p.displayName[0] : '?') : null,
              ),
              loading: () => const CircleAvatar(child: CircularProgressIndicator()),
              error: (_, __) => const CircleAvatar(child: Icon(Icons.error)),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  profileAsync.when(
                    data: (p) => Text(p.displayName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    loading: () => const Text('...', style: TextStyle(fontSize: 12)),
                    error: (_, __) => const Text('Unknown', style: TextStyle(fontSize: 12)),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(message.content),
                ),
                Text(
                  _formatTime(message.createdAt.toDateTime()),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isMe)
            ref
                .watch(authStateProvider)
                .when(
                  data: (u) => CircleAvatar(
                    backgroundImage: (u?.photoURL ?? '').isNotEmpty ? NetworkImage(u!.photoURL!) : null,
                    child: (u?.photoURL ?? '').isEmpty ? Text(u?.displayName?[0] ?? '?') : null,
                  ),
                  loading: () => const CircleAvatar(child: CircularProgressIndicator()),
                  error: (_, __) => const CircleAvatar(child: Icon(Icons.error)),
                ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
