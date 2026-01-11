import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_package/infrastructure/grpc/generated/proto/auth/v1/auth.pb.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';

import 'providers/invite_provider.dart';

class InviteGeneratorDialog extends ConsumerWidget {
  const InviteGeneratorDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inviteState = ref.watch(inviteControllerProvider);
    final isProcessing = inviteState.isLoading;

    return AlertDialog(
      title: const Text('Generate Invite Token'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select the purpose for this invite:'),
          const SizedBox(height: 16),
          // For now, let's just default to ADMIN_ONBOARDING as it's the main use case
          // In future iteration we can add a dropdown.
          const Chip(label: Text('Role: SUPER_ADMIN')),

          if (inviteState.hasError) ...[
            const SizedBox(height: 16),
            Text('Error: ${inviteState.error}', style: const TextStyle(color: Colors.red)),
          ],

          if (inviteState.value != null) ...[
            const SizedBox(height: 16),
            const Text('Token Generated:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      inviteState.value!.token,
                      style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: inviteState.value!.token));
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Token copied to clipboard')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Expires: ${inviteState.value!.expiresAt.toDateTime().toLocal()}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
      actions: [
        if (inviteState.value == null)
          TextButton(onPressed: isProcessing ? null : () => Navigator.of(context).pop(), child: const Text('Cancel')),

        if (inviteState.value == null)
          ElevatedButton(
            onPressed: isProcessing
                ? null
                : () => ref
                      .read(inviteControllerProvider.notifier)
                      .generateToken(auth_proto.TokenPurpose.TOKEN_PURPOSE_ADMIN_ONBOARDING),
            child: isProcessing
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Generate'),
          )
        else
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Done')),
      ],
    );
  }
}
