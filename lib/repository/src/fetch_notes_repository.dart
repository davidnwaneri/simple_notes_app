// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/src/user_account_local_storage_service.dart';
import 'package:simple_notes_app/remote_service/src/note/fetch_notes_remote_service.dart';

mixin IFetchNotesRepository {
  FutureEitherNotes fetchNotes();
}

class FetchNotesRepositoryImpl implements IFetchNotesRepository {
  const FetchNotesRepositoryImpl({
    required IFetchNotesRemoteService remoteService,
    required IUserAccountLocalStorageService userAccountLocalStorageService,
  })  : _remoteService = remoteService,
        _userAccountLocalStorageService = userAccountLocalStorageService;

  final IFetchNotesRemoteService _remoteService;
  final IUserAccountLocalStorageService _userAccountLocalStorageService;

  @override
  FutureEitherNotes fetchNotes() async {
    return _remoteService.fetchNotes(ownerId: _userId);
  }

  // The user id guaranteed to be available since the user must be signed in
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
