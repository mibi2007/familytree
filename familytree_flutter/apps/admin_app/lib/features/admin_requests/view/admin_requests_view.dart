import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/auth/v1/auth.pb.dart' as auth_proto;
import 'package:shared_package/data/grpc/generated/proto/common/v1/common.pb.dart' as common_proto;
import 'package:shared_package/shared_package.dart';

import '../../invites/view/invite_generator_dialog.dart';
import 'providers/admin_requests_provider.dart';

class AdminRequestsView extends ConsumerWidget {
  const AdminRequestsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Admin Management'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending Requests'),
              Tab(text: 'Manage Admins'),
            ],
          ),
        ),
        body: const TabBarView(children: [_PendingRequestsList(), _AdminManagementView()]),
      ),
    );
  }
}

class _PendingRequestsList extends ConsumerWidget {
  const _PendingRequestsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingRequestsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () => ref.invalidate(pendingRequestsProvider), icon: const Icon(Icons.refresh)),
              ],
            ),
          ),
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
                    return _RequestCard(key: ValueKey(req.id), request: req);
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

class _AdminManagementView extends ConsumerWidget {
  const _AdminManagementView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminsAsync = ref.watch(superAdminsProvider);
    final currentUserRef = ref.watch(currentUserProvider); // Make sure we have current user info
    // For specific root admin check:
    final isRootAdmin = currentUserRef.value?.email == 'binhhm2009@gmail.com';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Super Admins', style: Theme.of(context).textTheme.headlineSmall),
              IconButton(onPressed: () => ref.invalidate(superAdminsProvider), icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
        Expanded(
          child: adminsAsync.when(
            data: (admins) {
              return ListView.builder(
                itemCount: admins.length,
                itemBuilder: (context, index) {
                  final admin = admins[index];
                  // Do not show revoke button for self or if not root admin
                  final canRevoke = isRootAdmin && admin.email != 'binhhm2009@gmail.com';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: admin.photoUrl.isNotEmpty ? NetworkImage(admin.photoUrl) : null,
                      child: admin.photoUrl.isEmpty
                          ? Text(admin.displayName.isNotEmpty ? admin.displayName[0] : '?')
                          : null,
                    ),
                    title: Text(admin.displayName.isNotEmpty ? admin.displayName : 'Unknown Name'),
                    subtitle: Text(admin.email),
                    trailing: canRevoke
                        ? IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _confirmRevoke(context, ref, admin),
                          )
                        : null,
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ),
      ],
    );
  }

  void _confirmRevoke(BuildContext context, WidgetRef ref, common_proto.UserProfile admin) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Revoke Access'),
        content: Text('Are you sure you want to remove ${admin.email} from Super Admins?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(adminRequestsControllerProvider.notifier).revokeAdminRole(admin.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Revoke'),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends ConsumerStatefulWidget {
  final auth_proto.AdminAccessRequest request;

  const _RequestCard({super.key, required this.request});

  @override
  ConsumerState<_RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends ConsumerState<_RequestCard> {
  bool _isProcessing = false;

  Future<void> _handleDecision(bool approve) async {
    setState(() => _isProcessing = true);
    try {
      final controller = ref.read(adminRequestsControllerProvider.notifier);
      await controller.reviewRequest(widget.request.id, approve);

      // Wait a moment for the backend to process and then force refresh
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        // Force refresh the list
        ref.invalidate(pendingRequestsProvider);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(approve ? 'Request approved!' : 'Request rejected'),
            backgroundColor: approve ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red, duration: const Duration(seconds: 3)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final req = widget.request;
    final userProfile = req.userProfile;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            Padding(
              padding: const EdgeInsets.only(left: 56.0, top: 4.0),
              child: Text(
                'Requested: ${req.updatedAt.toDateTime().toLocal().toString().split('.')[0]}',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
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
