// 🌎 Project imports:
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_service.dart';

mixin ICreateNoteRepository {
  FutureEitherVoid createNote(Note note);
}

class CreateNoteRepositoryImpl implements ICreateNoteRepository {
  CreateNoteRepositoryImpl({
    required ICreateNoteRemoteService remoteService,
  }) : _remoteService = remoteService;

  final ICreateNoteRemoteService _remoteService;

  @override
  FutureEitherVoid createNote(Note note) {
    return _remoteService.createNote(note);
  }
}
