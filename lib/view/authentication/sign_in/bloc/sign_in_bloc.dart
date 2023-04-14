import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/service.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required ISignInRemoteService signInService,
  })  : _signInService = signInService,
        super(const SignInState.initial()) {
    on<SignInEventStarted>(_onSignInEventStarted);
  }

  final ISignInRemoteService _signInService;

  Future<void> _onSignInEventStarted(
    SignInEventStarted event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loading());
    final res = await _signInService.signIn(
      email: event.email,
      password: event.password,
    );
    res.fold(
      (l) => emit(SignInState.error(l.message)),
      (us) => emit(SignInState.success(userSession: us)),
    );
  }
}
