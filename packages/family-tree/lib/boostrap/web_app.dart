// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../src/auth/app/auth_provider.dart';
import '../src/navigation/app/router.dart';

class WebAppWidget extends ConsumerStatefulWidget {
  final AnimatedBuilder Function(WidgetRef) builder;
  const WebAppWidget({
    required this.builder,
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebAppWidget();
}

class _WebAppWidget extends ConsumerState<WebAppWidget> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    if (kIsWeb) {
      window.addEventListener('focus', (_) => didChangeAppLifecycleState(AppLifecycleState.resumed));
      window.addEventListener('blur', (_) => didChangeAppLifecycleState(AppLifecycleState.paused));
    }
  }

  @override
  void dispose() {
    print('dispose web_app');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final authState = ref.read(authNotifierProvider);
    if (authState == const AuthState.unAuthenticated()) return;
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrintStack(maxFrames: 3);
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final trackingNotifier = ref.read(trackingNotifierProvider.notifier);
    // ref.listen<AuthState>(authNotifierProvider, (s1, s2) {
    //   if (s2 == const AuthState.authenticated()) {
    //     trackingNotifier.enable();
    //   } else {
    //     trackingNotifier.disable();
    //   }
    // });
    AppRouter.init(ref);
    final authProvider = ref.read(authNotifierProvider.notifier);
    // authProvider.stateChanged();
    // ref.listen<AuthState>(authNotifierProvider, (previous, next) { });
    // return widget.builder(ref);
    return FutureBuilder(
      future: authProvider.stateChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) return Container();
        return widget.builder(ref);
      },
    );
  }
}
