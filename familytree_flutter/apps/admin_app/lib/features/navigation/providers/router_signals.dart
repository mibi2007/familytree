import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_package/shared_package.dart';

import '../../admin_requests/view/admin_requests_view.dart';
import '../../auth/view/admin_login_page.dart';
import '../../auth/view/admin_onboarding_page.dart';
import '../../dashboard/view/admin_dashboard_page.dart';
import '../../settings/view/settings_page.dart';
import '../view/main_layout.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Router refresh notifier using Signals
///
/// Watches authUserSignal and adminStatusSignal, notifying GoRouter
/// when auth state changes for redirect evaluation.
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier() {
    // Use effect to track signal changes and notify listeners
    _disposeEffect = effect(() {
      authUserSignal.value; // Track auth state changes
      adminStatusSignal.value; // Track admin status changes
      notifyListeners();
    });
  }

  late final EffectCleanup _disposeEffect;

  @override
  void dispose() {
    _disposeEffect();
    super.dispose();
  }
}

/// Signal-based GoRouter instance
///
/// Equivalent to: appRouterProvider
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  refreshListenable: RouterRefreshNotifier(),
  redirect: (context, state) {
    // Get values from AsyncState - use .value to unwrap
    final authState = authUserSignal.value;
    final statusState = adminStatusSignal.value;

    // Extract user from AsyncState
    final user = authState.map(data: (u) => u, loading: () => null, error: (_, _) => null);

    // Extract admin status from AsyncState
    final status = statusState.map(data: (s) => s, loading: () => null, error: (_, _) => null);

    final isLoggingIn = state.matchedLocation == '/login';

    // Not authenticated - redirect to login
    if (user == null) {
      return isLoggingIn ? null : '/login';
    }

    // Status still loading
    if (status == null) {
      return null;
    }

    // Not a super admin - redirect to onboarding
    if (!status.isSuperAdmin) {
      if (state.matchedLocation != '/onboarding') {
        return '/onboarding';
      }
      return null;
    }

    // Already authenticated and admin - redirect from login/onboarding to home
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
        return Watch((context) {
          return adminStatusSignal.value.map(
            data: (status) {
              if (status == null) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }
              return AdminOnboardingPage(status: status);
            },
            loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
            error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
          );
        });
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
