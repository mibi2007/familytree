import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../navigation/domain/app_paths.dart';
import '../app/auth_provider.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: 434,
                  child: SignInFormWrapper(ref: ref),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInFormWrapper extends StatelessWidget {
  final WidgetRef ref;
  const SignInFormWrapper({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 48),
          SignInForm(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class SignInForm extends HookConsumerWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey();
    final authNotifier = ref.read(authNotifierProvider.notifier);
    if (authNotifier.isSignedIn()) {
      context.go(AppPaths.home.path);
    }

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    authNotifier.signIn().then((value) {
                      context.go(AppPaths.home.path);
                    });
                  },
                  child: const Text('Sign In Google'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
