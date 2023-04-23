// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/src/user_account_local_storage_service.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';

mixin ICreateNoteRepository {
  FutureEitherVoid createNote(Note note);
}

class CreateNoteRepositoryImpl implements ICreateNoteRepository {
  CreateNoteRepositoryImpl({
    required ICreateNoteRemoteService remoteService,
    required IUserAccountLocalStorageService userAccountLocalStorageService,
  })  : _remoteService = remoteService,
        _userAccountLocalStorageService = userAccountLocalStorageService;

  final ICreateNoteRemoteService _remoteService;
  final IUserAccountLocalStorageService _userAccountLocalStorageService;

  @override
  FutureEitherVoid createNote(Note note) {
    return _remoteService.createNote(note: note, ownerId: _userId);
  }

  // The user id guarenteed to be available since the user must be signed in
  // to create a note. (Not putting into consideration that the [User] object
  // may not have been persisted to the local storage after signing in, though
  // it should)
  String get _userId {
    final user = _userAccountLocalStorageService.getCurrentUser();
    return user.fold(
      () => '',
      (user) => user.id,
    );
  }
}
