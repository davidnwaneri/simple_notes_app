import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';

mixin ISignUpRemoteService {
  FutureEitherVoid signUp({
    required String name,
    required String email,
    required String password,
  });
}

class SignUpRemoteServiceWithAppWrite implements ISignUpRemoteService {
  SignUpRemoteServiceWithAppWrite(this._account);

  final Account _account;

  @override
  FutureEitherVoid signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await _account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );
      return right(unit);
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
