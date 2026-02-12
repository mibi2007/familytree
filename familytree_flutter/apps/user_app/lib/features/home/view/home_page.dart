import 'package:flutter/material.dart';
import 'package:shared_package/data/grpc/generated/proto/family/v1/family.pbgrpc.dart' as family_proto;
import 'package:shared_package/shared_package.dart';
import 'package:user_app/l10n/app_localizations.dart';

import '../../family/view/create_family_dialog.dart';
import '../../family/view/family_tree_view_page.dart';
import '../../family/view/join_family_dialog.dart';
import '../../settings/view/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncUser());
  }

  Future<void> _syncUser() async {
    // Current user from signal
    final user = authUserSignal.value.value;

    if (user != null) {
      try {
        final client = authClientSignal.value;
        await client.syncUserProfile(
          SyncUserProfileRequest()
            ..displayName = user.displayName ?? ''
            ..photoUrl = user.photoURL ?? '',
        );
      } catch (e) {
        debugPrint('Failed to sync user: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch signals
    final userAsync = authUserSignal.watch(context);
    final user = userAsync.value;
    final l10n = AppLocalizations.of(context)!;

    final familiesAsync = myFamiliesSignal.watch(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [IconButton(onPressed: () => authSignalsController.signOut(), icon: const Icon(Icons.logout))],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? 'User'),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
                child: user?.photoURL == null ? const Icon(Icons.person) : null,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(l10n.settings),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => authSignalsController.signOut(),
            ),
          ],
        ),
      ),
      body: familiesAsync.map(
        data: (families) {
          if (families.isEmpty) {
            return _EmptyState(user: user);
          }
          return _FamilyList(families: families);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (context) => const CreateFamilyDialog()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final User? user;
  const _EmptyState({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.family_restroom, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 24),
            Text(
              'Welcome, ${user?.displayName ?? 'User'}!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'You are not part of any family tree yet. Start by creating your own family or join one via an invite link.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => showDialog(context: context, builder: (context) => const CreateFamilyDialog()),
              icon: const Icon(Icons.add),
              label: const Text('Create My Family'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _showJoinDialog(context),
              icon: const Icon(Icons.group_add),
              label: const Text('Join via Invite Token'),
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const JoinFamilyDialog());
  }
}

class _FamilyList extends StatelessWidget {
  final List<family_proto.Family> families;
  const _FamilyList({required this.families});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: families.length,
      itemBuilder: (context, index) {
        final family = families[index];
        return Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.groups)),
            title: Text(family.name),
            subtitle: Text('ID: ${family.id}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FamilyTreeViewPage(familyId: family.id, familyName: family.name),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
