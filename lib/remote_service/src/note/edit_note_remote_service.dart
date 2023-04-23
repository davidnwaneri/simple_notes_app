// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/src/note/note.dart';

mixin IEditNoteRemoteService {
  FutureEitherVoid editNote(Note note);
}

class EditNoteRemoteServiceWithAppWrite implements IEditNoteRemoteService {
  EditNoteRemoteServiceWithAppWrite({
    required Databases databases,
  }) : _databases = databases;

  final Databases _databases;

  static const _databaseId = String.fromEnvironment(
    'APPWRITE_NOTE_DATABASE_ID',
  );
  static const _collectionId = String.fromEnvironment(
    'APPWRITE_NOTE_COLLECTION_ID',
  );

  @override
  FutureEitherVoid editNote(Note note) async {
    try {
      'Note ID: ${note.id}'.log();
      await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: note.id!,
        data: note.toJson(),
      );
      return right(unit);
    } on AppwriteException catch (e, st) {
      'Stack trace: $st'.log();
      'Error: $e'.log();
      return left(
        EditNoteFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        EditNoteFailure(
          'An unexpected error occurred',
          stackTrace: st,
        ),
      );
    }
  }
}
