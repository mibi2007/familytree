import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

class CreateFamilyDialog extends ConsumerStatefulWidget {
  const CreateFamilyDialog({super.key});

  @override
  ConsumerState<CreateFamilyDialog> createState() => _CreateFamilyDialogState();
}

class _CreateFamilyDialogState extends ConsumerState<CreateFamilyDialog> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(familyControllerProvider.notifier).createFamily(_nameController.text.trim());
      // Refresh the families list
      ref.invalidate(myFamiliesProvider);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Family'),
      content: TextField(
        controller: _nameController,
        decoration: const InputDecoration(labelText: 'Family Name', hintText: 'e.g. The Smith Family'),
        enabled: !_isLoading,
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: _isLoading ? null : () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Create'),
        ),
      ],
    );
  }
}
