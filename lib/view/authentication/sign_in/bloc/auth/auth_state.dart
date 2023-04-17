part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.loading() = _Loading;

  const factory AuthState.signedIn(User user) = _SignedIn;

  const factory AuthState.signedOut() = _SignedOut;
}