import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

class CreateFamilyDialog extends StatefulWidget {
  const CreateFamilyDialog({super.key});

  @override
  State<CreateFamilyDialog> createState() => _CreateFamilyDialogState();
}

class _CreateFamilyDialogState extends State<CreateFamilyDialog> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty) return;

    // familySignalsController handles loading state internally if we wanted to watch it,
    // but here we are using local state for simplicity or we can watch the global signal.
    // However, the controller methods return Future, so we can await them.

    // We can use the controller's loading signal if we want, or keep local state.
    // Keeping local state to match existing behavior cleanly, but using signals for action.

    setState(() => _isLoading = true);
    try {
      await familySignalsController.createFamily(_nameController.text.trim());

      // Error handling via signal or return value?
      // createFamily in signals returns the Family object or null on error, and sets errorSignal.

      if (familySignalsController.error != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${familySignalsController.error}'), backgroundColor: Colors.red),
          );
        }
      } else {
        if (mounted) Navigator.of(context).pop();
      }
    } catch (e) {
      // Should be caught by controller, but just in case
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Local loading state because we might be in a dialog where we don't want to conflict
  // with other global loaders if any.
  bool _isLoading = false;

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
