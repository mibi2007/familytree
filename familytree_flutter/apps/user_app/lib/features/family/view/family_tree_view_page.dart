import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_package/shared_package.dart';

import '../../chat/view/chat_page.dart';
import 'widgets/family_tree_canvas.dart';

class FamilyTreeViewPage extends StatefulWidget {
  final String familyId;
  final String familyName;

  const FamilyTreeViewPage({super.key, required this.familyId, required this.familyName});

  @override
  State<FamilyTreeViewPage> createState() => _FamilyTreeViewPageState();
}

class _FamilyTreeViewPageState extends State<FamilyTreeViewPage> {
  bool _isTreeView = true;

  @override
  Widget build(BuildContext context) {
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
            tooltip: 'Invite Member',
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(familyId: widget.familyId, familyName: widget.familyName),
              ),
            ),
            icon: const Icon(Icons.chat),
            tooltip: 'Family Chat',
          ),
          IconButton(
            onPressed: () => setState(() => _isTreeView = !_isTreeView),
            icon: Icon(_isTreeView ? Icons.list : Icons.account_tree),
            tooltip: _isTreeView ? 'Switch to List' : 'Switch to Tree',
          ),
          IconButton(onPressed: () => reloadFamilyMembers(widget.familyId), icon: const Icon(Icons.refresh)),
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
                  const Text('No members found in this family.'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showAddMemberDialog(context),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add First Member'),
                  ),
                ],
              ),
            );
          }

          if (_isTreeView) {
            return FamilyTreeCanvas(members: members, onNodeTap: _handleNodeTap, onAddChild: _handleAddChild);
          }

          return ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return ListTile(
                leading: CircleAvatar(child: Text(member.displayName.isNotEmpty ? member.displayName[0] : '?')),
                title: Text(member.displayName),
                subtitle: Text(
                  'Level: ${member.level}${member.parentId.isNotEmpty ? ' | Parent: ${member.parentId}' : ''}',
                ),
                onTap: () => _handleNodeTap(member),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMemberDialog(context),
        child: const Icon(Icons.person_add),
      ),
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
              title: Text(member.displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('ID: ${member.id}\nLevel: ${member.level}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: Implement Edit
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Add Child'),
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

  void _handleAddChild(Member parent) {
    _showAddMemberDialog(context, parentId: parent.id);
  }

  void _showAddMemberDialog(BuildContext context, {String? parentId}) {
    showDialog(
      context: context,
      builder: (context) => _AddMemberDialog(familyId: widget.familyId, parentId: parentId),
    );
  }

  Future<void> _showInviteDialog(BuildContext context) async {
    try {
      final token = await familySignalsController.createInviteToken(widget.familyId);
      if (!mounted || token == null) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invite Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Share this token with your family member:'),
              const SizedBox(height: 16),
              SelectableText(token, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: token));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token copied!')));
              },
              icon: const Icon(Icons.copy),
              label: const Text('Copy'),
            ),
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
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
    // Watch loading state
    final isLoading = familySignalsController.isLoadingSignal.watch(context);

    return AlertDialog(
      title: Text(widget.parentId != null ? 'Add Child' : 'Add Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Display Name'),
            autofocus: true,
          ),
          if (widget.parentId != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Parent ID: ${widget.parentId}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
        ],
      ),
      actions: [
        TextButton(onPressed: isLoading ? null : () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: isLoading ? null : _handleAdd,
          child: isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Add'),
        ),
      ],
    );
  }

  Future<void> _handleAdd() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    await familySignalsController.addMember(familyId: widget.familyId, displayName: name, parentId: widget.parentId);

    if (familySignalsController.error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${familySignalsController.error}'), backgroundColor: Colors.red));
    } else {
      if (!mounted) return;
      Navigator.pop(context);
    }
  }
}
