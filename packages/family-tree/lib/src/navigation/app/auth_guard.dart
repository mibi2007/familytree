import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/app/auth_provider.dart';
import '../../navigation/domain/app_paths.dart';

Future<String?> guard(GoRouterState state, WidgetRef ref) async {
  final controller = ref.read(authNotifierProvider.notifier);
  final bool signedIn = controller.isSignedIn();

  // Go to sign-in if the user is not signed in
  if (!signedIn) {
    return AppPaths.signIn.path;
  }
  // Go to home if the user is signed in and tries to go to /signin.
  // else if (signedIn) {
  //   return AppPaths.home.path;
  // }

  // no redirect
  return null;
}
