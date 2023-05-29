part of 'auth_provider.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authenticatedHasAccess() = AuthenticatedHasAccess;
  const factory AuthState.authenticatedNoAccess() = AuthenticatedNoAccess;
  const factory AuthState.unAuthenticated() = UnAuthenticated;
}
