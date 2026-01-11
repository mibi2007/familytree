import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'features/auth/presentation/admin_login_page.dart';
import 'features/auth/presentation/admin_onboarding_page.dart';
import 'features/dashboard/presentation/admin_dashboard_page.dart';

class AdminApp extends StatelessWidget {
  final String title;
  final Color seedColor;

  const AdminApp({super.key, this.title = 'Family Chat Admin', this.seedColor = Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: seedColor)),
      home: const _AdminAuthWrapper(),
    );
  }
}

class _AdminAuthWrapper extends ConsumerWidget {
  const _AdminAuthWrapper();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    // Listen to AuthController errors
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString()), backgroundColor: Colors.red));
      }
    });

    return authState.when(
      data: (user) {
        if (user == null) return const AdminLoginPage();

        final adminStatus = ref.watch(adminStatusProvider);
        return adminStatus.when(
          data: (status) {
            if (status.isSuperAdmin) return const AdminDashboardPage();
            return AdminOnboardingPage(status: status);
          },
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (err, stack) => Scaffold(body: Center(child: Text('Error checking status: $err'))),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Auth Error: $err'))),
    );
  }
}
