import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_package/shared_package.dart' hide ConnectionState;
import 'package:user_app/l10n/app_localizations.dart';

import '../../ai/view/ai_assistant_page.dart';
import '../../chat/view/chat_page.dart';
import 'widgets/family_tree_canvas.dart';

class FamilyTreeViewPage extends StatefulWidget {
  final String familyId;
  final String familyName;

  const FamilyTreeViewPage({
    super.key,
    required this.familyId,
    required this.familyName,
  });

  @override
  State<FamilyTreeViewPage> createState() => _FamilyTreeViewPageState();
}

class _FamilyTreeViewPageState extends State<FamilyTreeViewPage> {
  bool _isTreeView = true;
  String? _actingMemberId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Watch signal via extension or signals_flutter Watch widget is implied if not used directly
    // Using .watch(context) from signals_flutter
    final membersAsync = familyMembersSignal(widget.familyId).watch(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.familyName),
        actions: [
          IconButton(
            onPressed: () => _showInviteDialog(context),
            icon: const Icon(Icons.share),
            tooltip: l10n.inviteMember,
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AIAssistantPage(
                  initialFamilyId: widget.familyId,
                  initialFamilyName: widget.familyName,
                ),
              ),
            ),
            icon: const Icon(Icons.auto_awesome),
            tooltip: l10n.familyAssistant,
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  familyId: widget.familyId,
                  familyName: widget.familyName,
                ),
              ),
            ),
            icon: const Icon(Icons.chat),
            tooltip: l10n.familyChat,
          ),
          IconButton(
            onPressed: () => setState(() => _isTreeView = !_isTreeView),
            icon: Icon(_isTreeView ? Icons.list : Icons.account_tree),
            tooltip: _isTreeView ? l10n.switchToList : l10n.switchToTree,
          ),
          IconButton(
            onPressed: () => reloadFamilyMembers(widget.familyId),
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refreshFamilyMembers,
          ),
        ],
      ),
      body: membersAsync.map(
        data: (members) {
          if (members.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(l10n.noMembersFound),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddMemberDialog(context),
                    icon: const Icon(Icons.person_add),
                    label: Text(l10n.addFirstMember),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: DropdownButtonFormField<String>(
                  initialValue: _actingMemberId,
                  decoration: InputDecoration(
                    labelText: l10n.showTitlesAs,
                    prefixIcon: Icon(Icons.translate),
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
              ),
              const SizedBox(height: 8),
              Expanded(child: _buildMemberContent(members)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text(l10n.errorMessage(err.toString()))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMemberDialog(context),
        tooltip: l10n.addFamilyMember,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildMemberContent(List<Member> members) {
    if (_isTreeView) {
      return FamilyTreeCanvas(
        members: members,
        onNodeTap: _handleNodeTap,
        onAddChild: _handleAddChild,
      );
    }

    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(
              member.displayName.isNotEmpty ? member.displayName[0] : '?',
            ),
          ),
          title: Text(member.displayName),
          subtitle: Text(
            [
              AppLocalizations.of(context)!.levelValue(member.level),
              if (member.parentId.isNotEmpty)
                AppLocalizations.of(context)!.parentValue(member.parentId),
            ].join(' | '),
          ),
          onTap: () => _handleNodeTap(member),
        );
      },
    );
  }

  void _handleNodeTap(Member member) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                member.displayName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${AppLocalizations.of(context)!.familyId(member.id)}\n'
                '${AppLocalizations.of(context)!.levelValue(member.level)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Implement Edit
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
            _buildKinshipTile(member),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: Text(AppLocalizations.of(context)!.addChild),
              onTap: () {
                Navigator.pop(context);
                _handleAddChild(member);
              },
            ),
            // TODO: Add Spouse
          ],
        ),
      ),
    );
  }

  Widget _buildKinshipTile(Member target) {
    final actingMemberId = _actingMemberId;
    if (actingMemberId == null) {
      return ListTile(
        leading: const Icon(Icons.translate),
        title: Text(AppLocalizations.of(context)!.selectShowTitles),
      );
    }

    return FutureBuilder<KinshipRelationship>(
      future: familySignalsController.getKinship(
        familyId: widget.familyId,
        actingMemberId: actingMemberId,
        targetMemberId: target.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            leading: const SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            title: Text(AppLocalizations.of(context)!.calculatingKinship),
          );
        }
        if (snapshot.hasError) {
          return ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(AppLocalizations.of(context)!.kinshipUnavailable),
          );
        }

        final relationship = snapshot.requireData;
        final details = [
          relationship.relationship,
          relationship.side,
          if (relationship.viaSpouse) AppLocalizations.of(context)!.viaSpouse,
          if (relationship.ambiguous)
            AppLocalizations.of(context)!.needsConfirmation,
        ].where((value) => value.isNotEmpty).join(' · ');
        return Semantics(
          label: AppLocalizations.of(
            context,
          )!.kinshipResult(relationship.title, details),
          child: ExcludeSemantics(
            child: ListTile(
              leading: const Icon(Icons.translate),
              title: Text(relationship.title),
              subtitle: Text(details),
            ),
          ),
        );
      },
    );
  }

  void _handleAddChild(Member parent) {
    _showAddMemberDialog(context, parentId: parent.id);
  }

  void _showAddMemberDialog(BuildContext context, {String? parentId}) {
    showDialog(
      context: context,
      builder: (context) =>
          _AddMemberDialog(familyId: widget.familyId, parentId: parentId),
    );
  }

  Future<void> _showInviteDialog(BuildContext context) async {
    try {
      final token = await familySignalsController.createInviteToken(
        widget.familyId,
      );
      if (!context.mounted || token == null) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.inviteMember),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppLocalizations.of(context)!.shareInviteToken),
              const SizedBox(height: 16),
              Semantics(
                label: AppLocalizations.of(context)!.inviteTokenValue(token),
                child: ExcludeSemantics(
                  child: SelectableText(
                    token,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: token));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.tokenCopied),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
              label: Text(AppLocalizations.of(context)!.copy),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.errorMessage(e.toString()),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _AddMemberDialog extends StatefulWidget {
  final String familyId;
  final String? parentId;
  const _AddMemberDialog({required this.familyId, this.parentId});

  @override
  State<_AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<_AddMemberDialog> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Watch loading state
    final isLoading = familySignalsController.isLoadingSignal.watch(context);

    return AlertDialog(
      title: Text(widget.parentId != null ? l10n.addChild : l10n.addMember),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: l10n.displayName),
            autofocus: true,
          ),
          if (widget.parentId != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                l10n.parentId(widget.parentId!),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _handleAdd,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.add),
        ),
      ],
    );
  }

  Future<void> _handleAdd() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    await familySignalsController.addMember(
      familyId: widget.familyId,
      displayName: name,
      parentId: widget.parentId,
    );

    if (familySignalsController.error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(
              context,
            )!.errorMessage(familySignalsController.error!),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
