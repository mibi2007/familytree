part of 'auth_provider.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.verify() = _Verify;
  const factory AuthState.error() = _Error;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unAuthenticated() = _UnAuthenticated;
}
