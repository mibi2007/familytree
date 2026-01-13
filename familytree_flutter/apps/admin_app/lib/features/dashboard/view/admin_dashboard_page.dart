import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import '../providers/health_provider.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Health',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const _HealthCheckWidget(),
          ],
        ),
      ),
    );
  }
}

class _HealthCheckWidget extends ConsumerWidget {
  const _HealthCheckWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthAsync = ref.watch(healthStatusProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: healthAsync.when(
          data: (health) => _buildHealthStatus(context, health),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildError(context, error),
        ),
      ),
    );
  }

  Widget _buildHealthStatus(BuildContext context, dynamic health) {
    final overallStatus = health.overallStatus;
    final statusColor = _getStatusColor(overallStatus);
    final statusIcon = _getStatusIcon(overallStatus);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(statusIcon, size: 32, color: statusColor),
            const SizedBox(width: 12),
            Text(
              'Backend Status',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Chip(
              label: Text(
                overallStatus,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              ),
              backgroundColor: statusColor.withValues(alpha: 0.1),
              side: BorderSide(color: statusColor),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildComponentRow(context, health.server),
        const Divider(height: 24),
        _buildComponentRow(context, health.database),
        const Divider(height: 24),
        _buildComponentRow(context, health.storage),
        const SizedBox(height: 16),
        Text(
          'Last checked: ${_formatTimestamp(health.checkedAt)}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildComponentRow(BuildContext context, dynamic component) {
    final status = component.status;
    final color = status == 'OK'
        ? Colors.green
        : status == 'ERROR'
        ? Colors.red
        : Colors.orange;

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(component.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              Text(component.message, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            ],
          ),
        ),
        if (component.responseTimeMs > 0)
          Text('${component.responseTimeMs}ms', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Column(
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Text('Failed to fetch health status', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          error.toString(),
          style: TextStyle(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'HEALTHY':
        return Colors.green;
      case 'DEGRADED':
        return Colors.orange;
      case 'UNHEALTHY':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'HEALTHY':
        return Icons.check_circle;
      case 'DEGRADED':
        return Icons.warning;
      case 'UNHEALTHY':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';
    try {
      final dt = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000 + timestamp.nanos ~/ 1000000);
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Unknown';
    }
  }
}
