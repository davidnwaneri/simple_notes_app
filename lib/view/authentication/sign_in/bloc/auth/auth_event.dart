part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CurrentLoggedInUserFetched extends AuthEvent {
  const CurrentLoggedInUserFetched();
}

class UserSignedOut extends AuthEvent {
  const UserSignedOut();
}
