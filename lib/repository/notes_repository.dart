import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/local_storage_service/src/user_account_local_storage_service.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/remote_appwrite_service.dart';

const invalidNotes = <Note>[];

class NotesRepository {
  NotesRepository({
    required RemoteAppWriteService remoteService,
    required IUserAccountLocalStorageService userAccountLocalStorageService,
  })  : _remoteService = remoteService,
        _userAccountLocalStorageService = userAccountLocalStorageService;

  final RemoteAppWriteService _remoteService;
  final IUserAccountLocalStorageService _userAccountLocalStorageService;

  final _notesSubject = BehaviorSubject<List<Note>>.seeded(invalidNotes);

  /// Map of note-id to [Note] object
  final _notesCache = <String, Note>{};

  List<Note> get currentNotes => _notesSubject.value != invalidNotes
      ? List.unmodifiable(_notesSubject.value)
      : invalidNotes;

  Stream<List<Note>> get streamNotes => _notesSubject.stream;

  void _updateSubject() {
    _notesSubject.add([..._notesCache.values]);
  }

  FutureEitherVoid fetchNotes() async {
    try {
      final notesFetched = await _remoteService.fetchNotes(ownerId: _userId);
      for (final note in notesFetched) {
        _notesCache[note.id!] = note;
      }
      _updateSubject();
      return right(unit);
    } catch (error, stackTrace) {
      // FIXME: Log error, stackTrace to server
      return left(
        FetchingNotesFailure('An error occurred while fetching notes'),
      );
    }
  }

  FutureEitherVoid createNote(Note note) async {
    try {
      final createdNote = await _remoteService.createNote(
        note.copyWith(ownerId: _userId),
      );
      _notesCache[createdNote.id!] = createdNote;
      _updateSubject();
      return right(unit);
    } catch (error, stackTrace) {
      return left(
        CreateNoteFailure('Sorry, could not create your note'),
      );
    }
  }

  FutureEitherVoid editNote(Note note) async {
    try {
      final newNote = await _remoteService.editNote(note);
      _notesCache[note.id!] = newNote;
      _updateSubject();
      return right(unit);
    } catch (error, stackTrace) {
      return left(
        EditNoteFailure('An unexpected error occurred'),
      );
    }
  }

  FutureEitherVoid deleteNote(Note note) async {
    try {
      await _remoteService.deleteNote(note);
      _notesCache.remove(note.id);
      _updateSubject();
      return right(unit);
    } catch (error, stackTrace) {
      return left(
        DeleteNoteFailure('An unexpected error occurred'),
      );
    }
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
