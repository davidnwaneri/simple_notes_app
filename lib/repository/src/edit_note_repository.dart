// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';

mixin IEditNoteRepository {
  FutureEitherVoid editNote(Note note);
}

class EditNoteRepositoryImpl implements IEditNoteRepository {
  const EditNoteRepositoryImpl({
    required IEditNoteRemoteService remoteService,
  }) : _remoteService = remoteService;

  final IEditNoteRemoteService _remoteService;
  @override
  FutureEitherVoid editNote(Note note) {
    return _remoteService.editNote(note);
  }
}
