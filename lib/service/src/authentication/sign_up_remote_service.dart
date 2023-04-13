import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';

mixin ISignUpRemoteService {
  FutureEitherUser signUp({
    required String name,
    required String email,
    required String password,
  });
}

class SignUpRemoteServiceWithAppWrite implements ISignUpRemoteService {
  SignUpRemoteServiceWithAppWrite(this._account);

  final Account _account;

  @override
  FutureEitherUser signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final acct = await _account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );
      final user = AccountUserAdapter.toUser(acct);
      return right(user);
    } on AppwriteException catch (e, st) {
      return left(
        SignUpFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      'SignUpFailure: Error($e), StackStrace($st)'.log();
      return left(
        SignUpFailure(
          'An unexpected error has occurred',
          stackTrace: st,
        ),
      );
    }
  }
}

/// Converts [models.Account] to [User]
class AccountUserAdapter {
  static User toUser(models.Account acct) {
    return User(
      id: acct.$id,
      name: acct.name,
      email: acct.email,
    );
  }
}
