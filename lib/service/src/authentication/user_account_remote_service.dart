import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';

abstract class IUserAccountRemoteService {
  FutureNullableUser getCurrentUser();
}

class UserAccountRemoteServiceWithAppWrite
    implements IUserAccountRemoteService {
  UserAccountRemoteServiceWithAppWrite(this._account);

  final Account _account;

  @override
  FutureNullableUser getCurrentUser() async {
    try {
      final acct = await _account.get();
      final user = UserAdapter.fromAccount(acct);
      return some(user);
    } on AppwriteException catch (e, st) {
      return none();
    } catch (e, st) {
      return none();
    }
  }
}

/// Converts [models.Account] to [User]
class UserAdapter {
  static User fromAccount(models.Account account) {
    return User(
      id: account.$id,
      name: account.name,
      email: account.email,
    );
  }
}
