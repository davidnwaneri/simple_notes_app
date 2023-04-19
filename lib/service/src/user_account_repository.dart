import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/src/authentication/sign_in_local_storage_service.dart';
import 'package:simple_notes_app/service/src/authentication/user_account_local_storage_service.dart';
import 'package:simple_notes_app/service/src/authentication/user_account_remote_service.dart';

abstract class IUserAccountRepository {
  FutureNullableUser getCurrentUser();

  FutureEitherVoid signOut({required String sessionId});

  Option<String> getUserSessionId();
}

class UserAccountRepository implements IUserAccountRepository {
  const UserAccountRepository({
    required ISignInLocalStorageService signInLocalStorageService,
    required IUserAccountLocalStorageService localStorageService,
    required IUserAccountRemoteService remoteService,
  })  : _signInLocalStorageService = signInLocalStorageService,
        _localStorageService = localStorageService,
        _remoteService = remoteService;

  final ISignInLocalStorageService _signInLocalStorageService;
  final IUserAccountLocalStorageService _localStorageService;
  final IUserAccountRemoteService _remoteService;

  @override
  FutureNullableUser getCurrentUser() {
    final userOrNullFromLocalStorage = _localStorageService.getCurrentUser();
    return userOrNullFromLocalStorage.fold(
      _userOrNullFromRemote,
      (user) => Future.value(some(user)),
    );
  }

  FutureNullableUser _userOrNullFromRemote() async {
    User? userDataToSave;
    try {
      final userOrNullFromRemote = await _remoteService.getCurrentUser();
      return userOrNullFromRemote.fold(
        none,
        (user) async {
          userDataToSave = user;
          return some(user);
        },
      );
    } finally {
      if (userDataToSave != null) {
        _localStorageService.saveCurrentUser(userDataToSave!).ignore();
      }
    }
  }

  @override
  FutureEitherVoid signOut({required String sessionId}) async {
    _localStorageService.deleteCurrentUserData().ignore();
    final res = await _remoteService.signOut(sessionId: sessionId);
    return res.fold(
      left,
      right,
    );
  }

  @override
  Option<String> getUserSessionId() {
    final res = _signInLocalStorageService.getUserSession();
    return res.fold(
      none,
      (us) => some(us.sessionId),
    );
  }
}
