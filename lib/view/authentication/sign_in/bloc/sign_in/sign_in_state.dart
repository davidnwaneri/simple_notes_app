part of 'sign_in_bloc.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;

  const factory SignInState.loading() = _Loading;

  const factory SignInState.success({
    required UserSession userSession,
  }) = _Success;

  const factory SignInState.error(String message) = _Error;
}
