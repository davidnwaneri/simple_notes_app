import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_notes_app/service/src/authentication/sign_up_remote_service.dart';

part 'sign_up_bloc.freezed.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required ISignUpRemoteService authService,
  })  : _authService = authService,
        super(const SignUpState.initial()) {
    on<SignUpEventStarted>(_onSignUpEventStarted);
  }

  final ISignUpRemoteService _authService;

  Future<void> _onSignUpEventStarted(
    SignUpEventStarted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpState.loading());
    final result = await _authService.signUp(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    result.fold(
      (failure) => emit(SignUpState.failure(msg: failure.message)),
      (user) => emit(const SignUpState.success()),
    );
  }
}
