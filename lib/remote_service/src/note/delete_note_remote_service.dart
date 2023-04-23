// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/src/note/note.dart';

mixin IDeleteNoteRemoteService {
  FutureEitherVoid deleteNote(Note note);
}

class DeleteNoteRemoteServiceWithAppWrite implements IDeleteNoteRemoteService {
  DeleteNoteRemoteServiceWithAppWrite({
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
  FutureEitherVoid deleteNote(Note note) async {
    try {
      await _databases.deleteDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: note.id!,
      );
      return right(unit);
    } on AppwriteException catch (e, st) {
      'Stack trace: $st'.log();
      'Error: $e'.log();
      return left(
        DeleteNoteFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        DeleteNoteFailure(
          'An unexpected error occurred',
          stackTrace: st,
        ),
      );
    }
  }
}
