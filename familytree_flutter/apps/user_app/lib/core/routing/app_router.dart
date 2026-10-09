import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';
import 'package:user_app/features/auth/view/login_page.dart';
import 'package:user_app/features/home/view/home_page.dart';

/// Adapter to make Signal compatible with GoRouter's refreshListenable
class SignalListenable extends ChangeNotifier {
  late final void Function() _dispose;

  SignalListenable(ReadonlySignal signal) {
    _dispose = effect(() {
      signal.value; // Access value to register dependency
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}

final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: SignalListenable(authUserSignal),
  redirect: (context, state) {
    final userState = authUserSignal.value;

    // Do not redirect while initial auth check is loading
    // This prevents premature redirect to login if we are actually logged in but just waiting for firebase
    if (userState is AsyncLoading) return null;

    final isLoggedIn = userState.value != null;
    final isLoggingIn = state.uri.path == '/login';

    // If not logged in, must be at login page
    if (!isLoggedIn) {
      return isLoggingIn ? null : '/login';
    }

    // If logged in, cannot be at login page
    if (isLoggingIn) {
      return '/';
    }

    // Otherwise, allow navigation
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  ],
);
