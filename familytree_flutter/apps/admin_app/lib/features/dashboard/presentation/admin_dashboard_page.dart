import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import '../../admin_requests/presentation/admin_requests_view.dart';

class AdminDashboardPage extends ConsumerStatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  ConsumerState<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends ConsumerState<AdminDashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).value;

    final content = [
      _DashboardHome(user: user),
      const AdminRequestsView(),
      const Center(child: Text('Audit Logs (Coming Soon)')),
    ];

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
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Overview'),
                  selected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Requests & Users'),
                  selected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Audit Logs'),
                  selected: _selectedIndex == 2,
                  onTap: () => setState(() => _selectedIndex = 2),
                ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: Padding(padding: const EdgeInsets.all(32.0), child: content[_selectedIndex]),
          ),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  final User? user;
  const _DashboardHome({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Welcome back, ${user?.displayName ?? 'Admin'}', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text('Signed in as: ${user?.email}'),
        const Divider(height: 64),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            StatCard(label: 'Total Users', value: '150'),
            StatCard(label: 'Families', value: '45'),
            StatCard(label: 'Pending Requests', value: '...'),
          ],
        ),
      ],
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
