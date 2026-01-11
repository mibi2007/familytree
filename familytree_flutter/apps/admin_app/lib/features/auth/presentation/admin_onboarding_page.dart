import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_package/infrastructure/grpc/generated/proto/auth/v1/auth.pb.dart' as auth_proto;
import 'package:shared_package/shared_package.dart';

class AdminOnboardingPage extends ConsumerStatefulWidget {
  final auth_proto.AuthStatusResponse status;

  const AdminOnboardingPage({super.key, required this.status});

  @override
  ConsumerState<AdminOnboardingPage> createState() => _AdminOnboardingPageState();
}

class _AdminOnboardingPageState extends ConsumerState<AdminOnboardingPage> {
  final _tokenController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _tokenController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final client = ref.read(authClientProvider);
      await client.requestAdminAccess(
        auth_proto.RequestAdminAccessRequest(
          invitationToken: _tokenController.text.trim(),
          reason: _reasonController.text.trim(),
          requestedRole: 'SUPER_ADMIN',
        ),
      );
      // Invalidate status to refresh UI
      // Use invalidate to force refresh
      ref.invalidate(adminStatusProvider);
    } catch (e) {
      if (mounted) {
        setState(() => _error = e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status.pendingRequestStatus == auth_proto.RequestStatus.REQUEST_STATUS_PENDING) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.hourglass_empty, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              Text('Access Pending', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text('Your request is currently under review.'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Admin Access'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Admin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (widget.status.pendingRequestStatus == auth_proto.RequestStatus.REQUEST_STATUS_REJECTED)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: const Text(
                        'Your previous request was rejected. You may submit a new one.',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  TextField(
                    controller: _tokenController,
                    decoration: const InputDecoration(
                      labelText: 'Invite Token',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.vpn_key),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _reasonController,
                    decoration: const InputDecoration(
                      labelText: 'Reason for Access',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitRequest,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: _isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Submit Request'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
