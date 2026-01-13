import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pb.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';

import '../../invites/view/invite_generator_dialog.dart';
import 'providers/admin_requests_provider.dart';

class AdminRequestsView extends ConsumerWidget {
  const AdminRequestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingRequestsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent, // Integrate seamlessly
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(context: context, builder: (context) => const InviteGeneratorDialog());
        },
        icon: const Icon(Icons.add),
        label: const Text('Invite Admin'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pending Requests', style: Theme.of(context).textTheme.headlineSmall),
              IconButton(onPressed: () => ref.invalidate(pendingRequestsProvider), icon: const Icon(Icons.refresh)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: requestsAsync.when(
              data: (requests) {
                if (requests.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_outline, size: 64, color: Colors.green[100]),
                        const SizedBox(height: 16),
                        const Text('No pending requests', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final req = requests[index];
                    return _RequestCard(request: req);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends ConsumerStatefulWidget {
  final auth_proto.AdminAccessRequest request;

  const _RequestCard({required this.request});

  @override
  ConsumerState<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends ConsumerState<_RequestCard> {
  bool _isProcessing = false;

  Future<void> _handleDecision(bool approve) async {
    setState(() => _isProcessing = true);
    final controller = ref.read(adminRequestsControllerProvider.notifier);
    await controller.reviewRequest(widget.request.id, approve);
    if (mounted) {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final req = widget.request;
    final userProfile = req.userProfile;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: userProfile.photoUrl.isNotEmpty ? NetworkImage(userProfile.photoUrl) : null,
                  child: userProfile.photoUrl.isEmpty
                      ? Text(userProfile.displayName.isNotEmpty ? userProfile.displayName[0] : '?')
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile.displayName.isNotEmpty ? userProfile.displayName : 'Unknown User',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(userProfile.email, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(req.requestedRole, style: TextStyle(color: Colors.blue[800], fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Reason:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(req.reason.isNotEmpty ? req.reason : "No reason provided."),
            const SizedBox(height: 16),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isProcessing)
                  const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                else ...[
                  TextButton.icon(
                    onPressed: () => _handleDecision(false),
                    icon: const Icon(Icons.close),
                    label: const Text('Reject'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _handleDecision(true),
                    icon: const Icon(Icons.check),
                    label: const Text('Approve'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
