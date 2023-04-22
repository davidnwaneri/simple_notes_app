// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';

abstract class IUserAccountRemoteService {
  FutureNullableUser getCurrentUser();

  FutureEitherVoid signOut({required String sessionId});
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
    } on AppwriteException catch (_) {
      return none();
    } catch (_) {
      return none();
    }
  }

  @override
  FutureEitherVoid signOut({required String sessionId}) async {
    try {
      await _account.deleteSession(sessionId: sessionId);
      return right(unit);
    } on AppwriteException catch (e, st) {
      return left(
        SignOutFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        SignOutFailure(
          'An unexpected error occurred',
          stackTrace: st,
        ),
      );
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
