// 📦 Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/local_storage_service/local_storage_service.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/repository/repository.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required IUserAccountRepository repository,
    required LocalStorageForm localStorageForm,
  })  : _localStorageForm = localStorageForm,
        _repository = repository,
        super(const AuthState.initial()) {
    on<CurrentLoggedInUserFetched>(_onFetchUserAccount);
    on<UserSignedOut>(_onSignOut);
  }

  final IUserAccountRepository _repository;
  final LocalStorageForm _localStorageForm;

  Future<void> _onFetchUserAccount(
    CurrentLoggedInUserFetched event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    final result = await _repository.getCurrentUser();
    result.fold(
      () => emit(const AuthState.signedOut()),
      (user) => emit(AuthState.signedIn(user)),
    );
  }

  Future<void> _onSignOut(UserSignedOut event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final sessionIdOrNull = _repository.getUserSessionId();
    await sessionIdOrNull.fold(
      () => null,
      (sessionId) async {
        await _localStorageForm.clearAll();
        await _repository.signOut(
          sessionId: sessionId,
        );
        emit(const AuthState.signedOut());
      },
    );
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    transition.log();
  }
}
