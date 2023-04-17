part of 'sign_up_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = _Loading;

  const factory SignUpState.success() = _Success;

  const factory SignUpState.failure({
    required String msg,
  }) = _Failure;
}
