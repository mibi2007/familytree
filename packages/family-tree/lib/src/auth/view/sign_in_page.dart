import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_package/shared_package.dart';

import '../../core/helper/translate.dart';
import '../../navigation/domain/app_paths.dart';
import '../../settings/view/language_switcher.dart';
import '../../settings/view/theme_switcher_widget.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 48),
          const SignInForm(),
          const SizedBox(height: 48),
          Row(
            children: [
              Text(t(context).language),
              AppSizesUnit.sizedBox16,
              const LanguageSwitcher(),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(t(context).themeMode),
              AppSizesUnit.sizedBox16,
              const ThemeSwitcher(),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class SignInForm extends HookConsumerWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    ref.listen(authNotifierProvider, (_, state) {
      // if(state is AuthState.authenticatedHasAccess()()){
      //   context.go(AppPaths.home.path);
      // }
      if (state == const AuthState.error()) {
        Flushbar().error(context, t(context).errorPleaseCheckAgain);
      }
    });
    if (authNotifier.isSignedIn()) {
      context.go(AppPaths.home.path);
    }
    final formKey = GlobalKey();
    final phoneNumberController = useTextEditingController();
    final verifyCodeController = useTextEditingController();
    String phoneNumber = '';
    String verifyCode = '';
    final state = ref.watch(authNotifierProvider);

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          if (state != const AuthState.verify()) ...[
            TextFormField(
              controller: phoneNumberController,
              onChanged: (value) => phoneNumber = value,
              decoration: InputDecoration(hintText: t(context).phoneNumber, prefixIcon: const Icon(Icons.phone)),
              keyboardType: TextInputType.phone,
            ),
            AppSizesUnit.sizedBox16,
            FilledButton(
              onPressed: state != const AuthState.loading()
                  ? () {
                      authNotifier.signInPhone(phoneNumber);
                    }
                  : null,
              child: Text('${t(context).signIn} ${t(context).phoneNumber.toLowerCase()}'),
            ),
          ],
          if (state == const AuthState.verify()) ...[
            TextFormField(
              controller: verifyCodeController,
              onChanged: (value) => verifyCode = value,
              decoration: InputDecoration(hintText: t(context).verifyCode, prefixIcon: const Icon(Icons.sms)),
              keyboardType: TextInputType.number,
            ),
            AppSizesUnit.sizedBox16,
            FilledButton(
              onPressed: state != const AuthState.loading()
                  ? () {
                      authNotifier.verifyPhone(verifyCode);
                    }
                  : null,
              child: Text(t(context).signIn),
            ),
          ],
          AppSizesUnit.sizedBox24,
          FilledButton(
            onPressed: state != const AuthState.loading()
                ? () {
                    authNotifier.signInGoogle().then((value) {
                      context.go(AppPaths.home.path);
                    });
                  }
                : null,
            child: Text('${t(context).signIn} Google'),
          ),
        ],
      ),
    );
  }
}
