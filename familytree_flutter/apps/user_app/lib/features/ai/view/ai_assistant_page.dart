import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';

class AIAssistantPage extends StatefulWidget {
  final String initialFamilyId;
  final String initialFamilyName;

  const AIAssistantPage({
    super.key,
    required this.initialFamilyId,
    required this.initialFamilyName,
  });

  @override
  State<AIAssistantPage> createState() => _AIAssistantPageState();
}

class _AIAssistantPageState extends State<AIAssistantPage> {
  final _questionController = TextEditingController();
  String? _familyId;
  String? _actingMemberId;

  @override
  void initState() {
    super.initState();
    _familyId = widget.initialFamilyId;
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _ask() async {
    final l10n = AppLocalizations.of(context)!;
    if (aiLoadingSignal.value) return;

    final familyId = _familyId;
    final memberId = _actingMemberId;
    if (familyId == null || memberId == null) {
      aiErrorSignal.value = l10n.selectFamilyAndMember;
      return;
    }
    final question = _questionController.text.trim();
    if (question.isEmpty) {
      aiErrorSignal.value = l10n.enterFamilyQuestion;
      return;
    }
    _questionController.clear();
    await askFamilyAI(
      familyId: familyId,
      actingMemberId: memberId,
      question: question,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final familiesAsync = myFamiliesSignal.watch(context);
    final selectedFamily = _familyId;
    final membersAsync = selectedFamily == null
        ? null
        : familyMembersSignal(selectedFamily).watch(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.familyAssistant),
        actions: [
          IconButton(
            tooltip: l10n.newChat,
            onPressed: clearAIChat,
            icon: const Icon(Icons.add_comment_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                familiesAsync.map(
                  data: (families) => DropdownButtonFormField<String>(
                    initialValue: _familyId,
                    decoration: InputDecoration(labelText: l10n.familyContext),
                    items: families
                        .map(
                          (family) => DropdownMenuItem(
                            value: family.id,
                            child: Text(family.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() {
                      _familyId = value;
                      _actingMemberId = null;
                    }),
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) =>
                      Text(l10n.couldNotLoadFamilies(error.toString())),
                ),
                const SizedBox(height: 8),
                if (membersAsync != null)
                  membersAsync.map(
                    data: (members) => DropdownButtonFormField<String>(
                      initialValue: _actingMemberId,
                      decoration: InputDecoration(labelText: l10n.actingAs),
                      items: members
                          .map(
                            (member) => DropdownMenuItem(
                              value: member.id,
                              child: Text(member.displayName),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _actingMemberId = value),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (error, _) =>
                        Text(l10n.couldNotLoadMembers(error.toString())),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Watch((context) {
              final messages = aiMessagesSignal.value;
              final error = aiErrorSignal.value;
              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  if (messages.isEmpty) Text(l10n.aiEmptyPrompt),
                  for (final message in messages)
                    Align(
                      alignment: message.fromUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Card(
                        color: message.fromUser
                            ? Theme.of(context).colorScheme.primaryContainer
                            : Theme.of(context).colorScheme.secondaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(message.text),
                        ),
                      ),
                    ),
                  if (error != null)
                    Text(
                      error,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  if (aiLoadingSignal.value)
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 12),
                          Text(l10n.familyThinking),
                        ],
                      ),
                    ),
                ],
              );
            }),
          ),
          Watch((context) {
            final loading = aiLoadingSignal.value;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _questionController,
                        enabled: !loading,
                        decoration: InputDecoration(
                          hintText: l10n.askFamilyHint,
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: loading ? null : (_) => _ask(),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.ask,
                      onPressed: loading ? null : _ask,
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
