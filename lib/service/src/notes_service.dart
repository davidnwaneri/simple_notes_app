import 'package:fpdart/fpdart.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/service/src/dummy_notes.dart';

abstract class INoteService {
  FutureEitherNotes fetchNotes();

  FutureEitherVoid createNote(Note note);
}

class DummyNoteService implements INoteService {
  @override
  FutureEitherNotes fetchNotes() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      return right(dummyNotes);
    } catch (e, st) {
      return left(
        FetchingNotesFailure(
          'Failed to fetch notes',
          stackTrace: st,
        ),
      );
    }
  }

  @override
  FutureEitherVoid createNote(Note note) {
    // TODO: implement createNote
    throw UnimplementedError();
  }
}