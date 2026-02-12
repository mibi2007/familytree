import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_package/shared_package.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Watch((context) {
      final user = authUserSignal.value.map(data: (u) => u, loading: () => null, error: (_, _) => null);

      return Container(
        width: 280,
        color: Colors.blueGrey[900],
        child: Column(
          children: [
            _buildHeader(user),
            const Divider(color: Colors.white24, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  _SidebarItem(
                    icon: Icons.dashboard_outlined,
                    label: 'Dashboard',
                    isSelected: location == '/',
                    onTap: () => context.go('/'),
                  ),
                  _SidebarItem(
                    icon: Icons.people_outline,
                    label: 'Admin Requests',
                    isSelected: location == '/requests',
                    onTap: () => context.go('/requests'),
                  ),
                  _SidebarItem(
                    icon: Icons.history,
                    label: 'Audit Logs',
                    isSelected: location == '/logs',
                    onTap: () {
                      // TODO: context.go('/logs');
                    },
                  ),
                  _SidebarItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    isSelected: location == '/settings',
                    onTap: () => context.go('/settings'),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            _SidebarItem(
              icon: Icons.logout,
              label: 'Logout',
              isSelected: false,
              onTap: () => authSignalsController.signOut(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Widget _buildHeader(User? user) {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.account_tree, color: Colors.blueAccent, size: 28),
              SMaterialSizedBox(width: 12),
              Text(
                'FT ADMIN',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (user != null) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blueGrey[700],
              backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : null,
              child: user.photoURL == null ? const Icon(Icons.person, color: Colors.white70) : null,
            ),
            const SizedBox(height: 12),
            Text(
              user.displayName ?? 'Admin',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              user.email ?? '',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({required this.icon, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.white60),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.blueAccent.withValues(alpha: 0.2),
        onTap: onTap,
        mouseCursor: SystemMouseCursors.click,
      ),
    );
  }
}

// Helper to avoid conflict with Material SizedBox if any
class SMaterialSizedBox extends StatelessWidget {
  final double? width;
  const SMaterialSizedBox({super.key, this.width});
  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
