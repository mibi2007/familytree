import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

import 'features/auth/presentation/login_page.dart';
import 'features/home/presentation/home_page.dart';

class UserApp extends StatelessWidget {
  final String title;
  final Color seedColor;

  const UserApp({super.key, this.title = 'Family Chat', this.seedColor = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: seedColor)),
      home: const _UserAuthWrapper(),
    );
  }
}

class _UserAuthWrapper extends ConsumerWidget {
  const _UserAuthWrapper();

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
      data: (user) => user != null ? const HomePage() : const LoginPage(),
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Auth Error: $err'))),
    );
  }
}
