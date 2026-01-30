import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_package/shared_package.dart';

import '../../admin_requests/view/admin_requests_view.dart';
import '../../auth/view/admin_login_page.dart';
import '../../auth/view/admin_onboarding_page.dart';
import '../../dashboard/view/admin_dashboard_page.dart';
import '../view/main_layout.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);
  final adminStatus = ref.watch(adminStatusProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      final user = authState.value;
      final status = adminStatus.value;

      final isLoggingIn = state.matchedLocation == '/login';

      if (user == null) {
        return isLoggingIn ? null : '/login';
      }

      if (status == null) {
        // Still loading admin status, or error
        return null;
      }

      if (!status.isSuperAdmin) {
        if (state.matchedLocation != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }

      // If user is logged in and is admin, redirect from login to home
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
          final status = adminStatus.value;
          if (status == null) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return AdminOnboardingPage(status: status);
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const AdminDashboardPage()),
          GoRoute(path: '/requests', builder: (context, state) => const AdminRequestsView()),
          // Add more admin routes here (Users, Logs, etc.)
        ],
      ),
    ],
  );
}
