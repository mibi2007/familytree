import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

class JoinFamilyDialog extends StatefulWidget {
  const JoinFamilyDialog({super.key});

  @override
  State<JoinFamilyDialog> createState() => _JoinFamilyDialogState();
}

class _JoinFamilyDialogState extends State<JoinFamilyDialog> {
  final _tokenController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Join Family'),
      content: TextField(
        controller: _tokenController,
        decoration: const InputDecoration(labelText: 'Invite Token', hintText: 'Enter the 32-character token'),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: _isLoading ? null : () => Navigator.pop(context), child: const Text('Cancel')),
        Consumer(
          builder: (context, ref, _) {
            return ElevatedButton(
              onPressed: _isLoading ? null : () => _handleJoin(context, ref),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Join'),
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleJoin(BuildContext context, WidgetRef ref) async {
    final token = _tokenController.text.trim();
    if (token.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(familyControllerProvider.notifier).joinFamily(token);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully joined family!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to join: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
