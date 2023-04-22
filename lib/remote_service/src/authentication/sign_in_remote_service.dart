// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';

mixin ISignInRemoteService {
  FutureEitherUserSession signIn({
    required String email,
    required String password,
  });
}

class SignInRemoteServiceWithAppWrite implements ISignInRemoteService {
  SignInRemoteServiceWithAppWrite(this._account);

  final Account _account;

  @override
  FutureEitherUserSession signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      final userSession = SessionAdapter.toUserSession(session);
      return right(userSession);
    } on AppwriteException catch (e, st) {
      return left(
        SignInFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      'SignInFailure: Error($e), StackStrace($st)'.log();
      return left(
        SignInFailure(
          'An unexpected error has occurred',
          stackTrace: st,
        ),
      );
    }
  }
}

/// Converts [models.Session] to [UserSession]
class SessionAdapter {
  static UserSession toUserSession(models.Session session) {
    return UserSession(
      sessionId: session.$id,
      userId: session.userId,
      createdAt: session.$createdAt,
      expireAt: session.expire,
    );
  }
}
