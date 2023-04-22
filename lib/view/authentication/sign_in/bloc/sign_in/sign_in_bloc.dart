import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_notes_app/repository/repository.dart';

part 'sign_in_bloc.freezed.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required ISignInRepository repository,
  })  : _repository = repository,
        super(const SignInState.initial()) {
    on<SignInEventStarted>(_onSignInEventStarted);
  }

  final ISignInRepository _repository;

  Future<void> _onSignInEventStarted(
    SignInEventStarted event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInState.loading());
    final res = await _repository.signIn(
      email: event.email,
      password: event.password,
    );
    res.fold(
      (l) => emit(SignInState.error(l.message)),
      (_) => emit(const SignInState.success()),
    );
  }
}
