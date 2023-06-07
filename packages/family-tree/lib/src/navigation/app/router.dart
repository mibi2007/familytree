import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_package/shared_package.dart';

import '../../auth/app/auth_provider.dart';
import '../../auth/view/sign_in_page.dart';
import '../../home/home_page.dart';
import '../../navigation/app/auth_guard.dart';
import '../../navigation/domain/app_paths.dart';
import '../../settings/app/settings_controller.dart';
import '../../settings/view/language_settings_page.dart';
import '../../settings/view/settings_page.dart';
import '../../settings/view/theme_settings_page.dart';

class AppRouter {
  AppRouter._();

  static bool isInitialized = false;
  static late GoRouter router;
  static final List<AppPath> _redirects = [];

  factory AppRouter.init(WidgetRef ref) {
    if (isInitialized) return AppRouter._();
    final authNotifier = ref.read(authNotifierProvider.notifier);

    router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) => const HomePage(),
          redirect: (_, state) => guard(state, ref),
        ),
        GoRoute(
          path: '/design',
          builder: (BuildContext context, GoRouterState state) => DesignPage(
            themeMode: ref.watch(settingsNotifierProvider).themeMode,
            onThemeModeChanged: (ThemeMode value) {
              ref.read(settingsNotifierProvider.notifier).updateThemeMode(value);
            },
          ),
        ),
        GoRoute(
          path: AppPaths.signIn.path,
          pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SignInPage(),
            transitionsBuilder: _slideTransitionBuilder(),
          ),
        ),
        GoRoute(
          path: AppPaths.settings.path,
          builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'theme',
              pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ThemeSettingsPage(),
                transitionsBuilder: _slideTransitionBuilder(),
              ),
            ),
            GoRoute(
              path: 'language',
              pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
                key: state.pageKey,
                child: const LanguageSettingsPage(),
                transitionsBuilder: _slideTransitionBuilder(),
              ),
            ),
          ],
        ),
      ],
      refreshListenable: GoRouterRefreshStream(authNotifier.stream),
      debugLogDiagnostics: true,
      observers: [GoRouterObserver()],
    );

    isInitialized = true;

    return AppRouter._();
  }

  static pushRedirect(String serverRedirectName) {
    _redirects.add(AppPaths.getByRedirectName(serverRedirectName));
  }

  static void redirect() {
    final redirect = _redirects.isNotEmpty ? _redirects.first : null;
    if (redirect != null) {
      router.go(redirect.path);
    } else {
      router.go(AppPaths.home.path);
    }
    _redirects.clear();
  }
}

_slideTransitionBuilder() =>
    (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) =>
        SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeIn)),
          ),
          child: GestureDetector(
              onTapDown: (details) {
                print(details);
              },
              child: child),
        );

class GoRouterObserver extends NavigatorObserver {
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}

// extension AppRouteHelper on BuildContext {
//   void canPop() {
//     try {
//       GoRouter.of(this).pop();
//     } catch (e) {
//       GoRouter.of(this).go(AppPaths.home.path);
//     }
//   }
// }

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
