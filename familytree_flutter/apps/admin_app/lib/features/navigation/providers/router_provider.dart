import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/shared_package.dart';

import '../../admin_requests/view/admin_requests_view.dart';
import '../../auth/view/admin_login_page.dart';
import '../../auth/view/admin_onboarding_page.dart';
import '../../dashboard/view/admin_dashboard_page.dart';
import '../../settings/view/settings_page.dart';
import '../view/main_layout.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Use refreshListenable to trigger redirects without rebuilding the GoRouter object
  final refreshListenable = _RouterRefreshStream(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      // Use ref.read to get current values without establishing a dependency
      // that would recreate this GoRouter instance.
      final user = ref.read(authStateProvider).value;
      final status = ref.read(adminStatusProvider).value;

      final isLoggingIn = state.matchedLocation == '/login';

      if (user == null) {
        return isLoggingIn ? null : '/login';
      }

      if (status == null) {
        return null;
      }

      if (!status.isSuperAdmin) {
        if (state.matchedLocation != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }

      if (isLoggingIn || state.matchedLocation == '/onboarding') {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const AdminLoginPage()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          return Consumer(
            builder: (context, ref, _) {
              final status = ref.watch(adminStatusProvider).value;
              if (status == null) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              return AdminOnboardingPage(status: status);
            },
          );
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const AdminDashboardPage()),
          GoRoute(path: '/requests', builder: (context, state) => const AdminRequestsView()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
        ],
      ),
    ],
  );
}

/// Simple class to bridge Riverpod and GoRouter's refresh protocol
class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(Ref ref) {
    _subscription = ref.listen(authStateProvider, (_, __) => notifyListeners());
    _statusSubscription = ref.listen(adminStatusProvider, (_, __) => notifyListeners());
  }

  late final ProviderSubscription<AsyncValue<dynamic>> _subscription;
  late final ProviderSubscription<AsyncValue<dynamic>> _statusSubscription;

  @override
  void dispose() {
    _subscription.close();
    _statusSubscription.close();
    super.dispose();
  }
}
