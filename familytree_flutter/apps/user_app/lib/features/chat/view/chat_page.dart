import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/chat/v1/chat.pbgrpc.dart'
    as chat_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  final String familyId;
  final String familyName;
  final bool autoLoad;
  final String? initialActingMemberId;
  final bool showActingMemberSelector;
  final Future<void> Function(String familyId, String content)?
  sendMessageOverride;
  final Future<void> Function(
    String familyId,
    String actingMemberId,
    String question,
  )?
  mentionOverride;

  const ChatPage({
    super.key,
    required this.familyId,
    required this.familyName,
    this.autoLoad = true,
    this.initialActingMemberId,
    this.showActingMemberSelector = true,
    this.sendMessageOverride,
    this.mentionOverride,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  StreamSubscription<chat_proto.Message>? _messageSubscription;
  String? _actingMemberId;

  @override
  void initState() {
    super.initState();
    _actingMemberId = widget.initialActingMemberId;
    if (widget.autoLoad) {
      loadMessages(widget.familyId);
      _messageSubscription = streamMessages(widget.familyId);
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final l10n = AppLocalizations.of(context)!;
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    final send = widget.sendMessageOverride;
    if (send == null) {
      await sendMessage(widget.familyId, content);
    } else {
      await send(widget.familyId, content);
    }
    _messageController.clear();

    if (containsFamilyMention(content)) {
      final memberId = _actingMemberId;
      if (memberId == null || memberId.isEmpty) {
        aiErrorSignal.value = l10n.selectActingMember;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.selectActingMember),
            ),
          );
        }
        return;
      }
      final mention = widget.mentionOverride;
      final responseSucceeded = mention == null
          ? await askFamilyAI(
                  familyId: widget.familyId,
                  actingMemberId: memberId,
                  question: content,
                  groupChat: true,
                  conversationRef: widget.familyId,
                ) !=
                null
          : await mention(widget.familyId, memberId, content).then((_) => true);
      if (!responseSucceeded && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(aiErrorSignal.value ?? '@family request failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.chatTitle(widget.familyName))),
      body: Column(
        children: [
          if (widget.showActingMemberSelector) _buildActingMemberSelector(),
          Expanded(
            child: Watch((context) {
              return mergedChatMessagesSignal(widget.familyId).value.map(
                data: (messages) {
                  return _MessageList(
                    messages: messages,
                    scrollController: _scrollController,
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, __) =>
                    Center(child: Text(l10n.errorMessage(err.toString()))),
              );
            }),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildActingMemberSelector() {
    return familyMembersSignal(widget.familyId)
        .watch(context)
        .map(
          data: (members) {
            if (members.isEmpty) return const SizedBox.shrink();
            final currentUserId = authUserSignal.value.value?.uid;
            var selectedMemberId = _actingMemberId;
            if (selectedMemberId == null) {
              for (final member in members) {
                if (member.userId == currentUserId) {
                  selectedMemberId = member.id;
                  break;
                }
              }
              selectedMemberId ??= members.first.id;
              final defaultMemberId = selectedMemberId;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && _actingMemberId == null) {
                  setState(() => _actingMemberId = defaultMemberId);
                }
              });
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: DropdownButtonFormField<String>(
                initialValue: selectedMemberId,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.actingAsFamily,
                  isDense: true,
                ),
                items: members
                    .map(
                      (member) => DropdownMenuItem(
                        value: member.id,
                        child: Text(member.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _actingMemberId = value),
              ),
            );
          },
          loading: () => const LinearProgressIndicator(),
          error: (_, _) => const SizedBox.shrink(),
        );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.typeMessage,
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
            color: Theme.of(context).primaryColor,
            tooltip: AppLocalizations.of(context)!.sendMessage,
          ),
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
      return Center(child: Text(AppLocalizations.of(context)!.noMessagesYet));
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

class _MessageItem extends StatelessWidget {
  final chat_proto.Message message;

  const _MessageItem({required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == chat_proto.MessageType.MESSAGE_TYPE_AI) {
      return Semantics(
        container: true,
        label: AppLocalizations.of(context)!.chatMessage(message.content),
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.auto_awesome)),
          title: const Text('@family'),
          subtitle: Text(message.content),
        ),
      );
    }
    return Semantics(
      container: true,
      label: AppLocalizations.of(context)!.chatMessage(message.content),
      child: Watch((context) {
        final currentUser = authUserSignal.value.map(
          data: (user) => user,
          loading: () => null,
          error: (_, __) => null,
        );
        final isMe = currentUser?.uid == message.senderId;

        return Watch((context) {
          final profileAsync = getUserProfileSignal(message.senderId).value;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  profileAsync.map(
                    data: (p) => CircleAvatar(
                      backgroundImage: p.photoUrl.isNotEmpty
                          ? NetworkImage(p.photoUrl)
                          : null,
                      child: p.photoUrl.isEmpty
                          ? Text(
                              p.displayName.isNotEmpty ? p.displayName[0] : '?',
                            )
                          : null,
                    ),
                    loading: () =>
                        const CircleAvatar(child: CircularProgressIndicator()),
                    error: (_, __) =>
                        const CircleAvatar(child: Icon(Icons.error)),
                  ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        profileAsync.map(
                          data: (p) => Text(
                            p.displayName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          loading: () =>
                              const Text('...', style: TextStyle(fontSize: 12)),
                          error: (_, __) => Text(
                            AppLocalizations.of(context)!.unknownUser,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(message.content),
                      ),
                      Text(
                        _formatTime(message.createdAt.toDateTime()),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (isMe)
                  authUserSignal.value.map(
                    data: (u) => CircleAvatar(
                      backgroundImage: (u?.photoURL ?? '').isNotEmpty
                          ? NetworkImage(u!.photoURL!)
                          : null,
                      child: (u?.photoURL ?? '').isEmpty
                          ? Text(u?.displayName?[0] ?? '?')
                          : null,
                    ),
                    loading: () =>
                        const CircleAvatar(child: CircularProgressIndicator()),
                    error: (_, __) =>
                        const CircleAvatar(child: Icon(Icons.error)),
                  ),
              ],
            ),
          );
        });
      }),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
