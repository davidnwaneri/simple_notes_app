import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/src/authentication/user_account_local_storage_service.dart';
import 'package:simple_notes_app/service/src/authentication/user_account_remote_service.dart';

abstract class IUserAccountRepository {
  FutureNullableUser getCurrentUser();
}

class UserAccountRepository implements IUserAccountRepository {
  const UserAccountRepository({
    required IUserAccountLocalStorageService localStorageService,
    required IUserAccountRemoteService remoteService,
  })  : _localStorageService = localStorageService,
        _remoteService = remoteService;

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
}
