import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/local_storage/local_storage.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';

mixin ISignInLocalStorageService {
  FutureEitherVoid saveUserSession({required UserSession userSession});
  Option<UserSession> getUserSession();
  FutureEitherVoid deleteUserSession();
}

class SignInLocalStorageService implements ISignInLocalStorageService {
  const SignInLocalStorageService({
    required ILocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  final ILocalStorageService _localStorageService;

  @override
  FutureEitherVoid saveUserSession({required UserSession userSession}) {
    final json = jsonEncode(userSession.toJson());
    return _localStorageService.save(
      key: 'session',
      value: json,
    );
  }

  @override
  Option<UserSession> getUserSession() {
    final res = _localStorageService.read('session');
    return res.fold(
      none,
      (json) => some(_userSessionFromJson(json)),
    );
  }

  UserSession _userSessionFromJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return UserSession.fromJson(map);
  }

  @override
  FutureEitherVoid deleteUserSession() {
    return _localStorageService.delete('session');
  }
}
