import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/local_storage_service.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';

mixin ISignInRepository {
  FutureEitherVoid signIn({
    required String email,
    required String password,
  });
}

class SignInRepository implements ISignInRepository {
  const SignInRepository({
    required ISignInLocalStorageService localStorageService,
    required ISignInRemoteService remoteService,
  })  : _localStorageService = localStorageService,
        _remoteService = remoteService;

  final ISignInLocalStorageService _localStorageService;
  final ISignInRemoteService _remoteService;

  @override
  FutureEitherVoid signIn({
    required String email,
    required String password,
  }) async {
    UserSession? userSessionToSave;
    try {
      final resFromRemote = await _remoteService.signIn(
        email: email,
        password: password,
      );
      return resFromRemote.fold(
        left,
        (us) {
          userSessionToSave = us;
          return right(unit);
        },
      );
    } finally {
      if (userSessionToSave != null) {
        _localStorageService
            .saveUserSession(
              userSession: userSessionToSave!,
            )
            .ignore();
      }
    }
  }
}
