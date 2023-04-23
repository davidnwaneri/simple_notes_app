// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';

mixin IDeleteNoteRepository {
  FutureEitherVoid deleteNote(Note note);
}

class DeleteNoteRepositoryImpl implements IDeleteNoteRepository {
  DeleteNoteRepositoryImpl({
    required IDeleteNoteRemoteService remoteService,
  }) : _remoteService = remoteService;

  final IDeleteNoteRemoteService _remoteService;

  @override
  FutureEitherVoid deleteNote(Note note) {
    return _remoteService.deleteNote(note);
  }
}
