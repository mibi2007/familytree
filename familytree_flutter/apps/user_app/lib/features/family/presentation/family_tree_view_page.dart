import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import '../../chat/presentation/chat_page.dart';
import 'widgets/family_tree_canvas.dart';

class FamilyTreeViewPage extends ConsumerStatefulWidget {
  final String familyId;
  final String familyName;

  const FamilyTreeViewPage({super.key, required this.familyId, required this.familyName});

  @override
  ConsumerState<FamilyTreeViewPage> createState() => _FamilyTreeViewPageState();
}

class _FamilyTreeViewPageState extends ConsumerState<FamilyTreeViewPage> {
  bool _isTreeView = true;

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(familyMembersProvider(widget.familyId));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.familyName),
        actions: [
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
          IconButton(
            onPressed: () => ref.invalidate(familyMembersProvider(widget.familyId)),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: membersAsync.when(
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
                    onPressed: () => _showAddMemberDialog(context, ref),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add First Member'),
                  ),
                ],
              ),
            );
          }

          if (_isTreeView) {
            return FamilyTreeCanvas(members: members);
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
                onTap: () {
                  // TODO: Member details or edit
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMemberDialog(context, ref),
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => _AddMemberDialog(familyId: widget.familyId),
    );
  }
}

class _AddMemberDialog extends StatefulWidget {
  final String familyId;
  const _AddMemberDialog({required this.familyId});

  @override
  State<_AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<_AddMemberDialog> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Member'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Display Name'),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: _isLoading ? null : () => Navigator.pop(context), child: const Text('Cancel')),
        Consumer(
          builder: (context, ref, _) {
            return ElevatedButton(
              onPressed: _isLoading ? null : () => _handleAdd(context, ref),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Add'),
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleAdd(BuildContext context, WidgetRef ref) async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(familyControllerProvider.notifier).addMember(familyId: widget.familyId, displayName: name);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
