import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/service.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required IUserAccountRemoteService userAccountRemoteService,
  })  : _userAccountRemoteService = userAccountRemoteService,
        super(const AuthState.initial()) {
    on<CurrentLoggedInUserFetched>(_onFetchUserAccount);
  }

  final IUserAccountRemoteService _userAccountRemoteService;

  Future<void> _onFetchUserAccount(
    CurrentLoggedInUserFetched event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _userAccountRemoteService.getCurrentUser();
    result.fold(
      () => emit(const AuthState.signedOut()),
      (user) => emit(AuthState.signedIn(user)),
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    transition.log();
  }
}
