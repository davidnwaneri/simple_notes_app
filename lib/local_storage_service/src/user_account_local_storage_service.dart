// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/local_storage_service.dart';
import 'package:simple_notes_app/models/models.dart';

abstract class IUserAccountLocalStorageService {
  FutureEitherVoid saveCurrentUser(User user);

  Option<User> getCurrentUser();

  FutureEitherVoid deleteCurrentUserData();
}

class UserAccountLocalStorageService
    implements IUserAccountLocalStorageService {
  const UserAccountLocalStorageService({
    required ILocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  final ILocalStorageService _localStorageService;

  @override
  FutureEitherVoid saveCurrentUser(User user) {
    final json = jsonEncode(user.toJson());
    return _localStorageService.save(
      key: 'user',
      value: json,
    );
  }

  @override
  Option<User> getCurrentUser() {
    final res = _localStorageService.read('user');
    return res.fold(
      none,
      (json) => some(_userFromJson(json)),
    );
  }

  User _userFromJson(String json) {
    final map = jsonDecode(json) as Map<String, dynamic>;
    return User.fromJson(map);
  }

  @override
  FutureEitherVoid deleteCurrentUserData() async {
    return _localStorageService.delete('user');
  }
}
