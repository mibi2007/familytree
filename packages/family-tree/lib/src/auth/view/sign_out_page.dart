import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../navigation/domain/app_paths.dart';
import '../app/auth_provider.dart';

class SignOutPage extends ConsumerStatefulWidget {
  const SignOutPage({super.key});

  @override
  ConsumerState<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends ConsumerState<SignOutPage> {
  @override
  void initState() {
    ref.read(authNotifierProvider.notifier).signOut().then((value) {
      context.go(AppPaths.signIn.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Loging out...'),
      ),
    );
  }
}
