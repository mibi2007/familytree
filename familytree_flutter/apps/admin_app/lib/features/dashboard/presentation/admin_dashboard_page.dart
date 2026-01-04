import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Row(
        children: [
          // Basic Sidebar
          Container(
            width: 250,
            color: Colors.blueGrey[50],
            child: ListView(
              children: [
                const DrawerHeader(
                  child: Center(child: Icon(Icons.shield, size: 48, color: Colors.blueGrey)),
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('User Management'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.family_restroom),
                  title: const Text('Family Support'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Audit Logs'),
                  onTap: () {},
                ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, ${user?.displayName ?? 'Admin'}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Signed in as: ${user?.email}'),
                  const Divider(height: 64),
                  const Text('System Overview Stubs...'),
                  const SizedBox(height: 32),
                  const Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      StatCard(label: 'Total Users', value: '150'),
                      StatCard(label: 'Families', value: '45'),
                      StatCard(label: 'Pending Requests', value: '3'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
