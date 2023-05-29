import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/data/auth_service.dart' as auth_service;
import '../domain/i_auth.dart';
import '../domain/user.dart';
import 'auth_provider.dart';

part 'current_user_provider.freezed.dart';
part 'current_user_state.dart';

class CurrentUserNotifier extends StateNotifier<CurrentUserState> {
  final IAuthApi authApi;
  CurrentUserNotifier._(this.authApi) : super(CurrentUserState.initialize());
  Future<Unit> logedIn() async {
    state = CurrentUserState.initialize();
    final userEither = await auth_service.getUser().run(authApi);
    state = CurrentUserState(userOption: Option.fromEither(userEither));
    return unit;
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, CurrentUserState>(
    (ref) => CurrentUserNotifier._(ref.read(authApiProvider)));