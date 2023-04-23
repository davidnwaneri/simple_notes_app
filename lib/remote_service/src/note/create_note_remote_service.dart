// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/src/note/note.dart';

mixin ICreateNoteRemoteService {
  FutureEitherVoid createNote({
    required Note note,
    required String ownerId,
  });
}

class CreateNoteRemoteServiceWithAppWrite implements ICreateNoteRemoteService {
  CreateNoteRemoteServiceWithAppWrite({
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
  FutureEitherVoid createNote({
    required Note note,
    required String ownerId,
  }) async {
    try {
      final nNote = note.copyWith(
        ownerId: ownerId,
      );
      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: note.id!,
        data: nNote.toJson(),
      );
      return right(unit);
    } on AppwriteException catch (e, st) {
      'Stack trace: $st'.log();
      'Error: $e'.log();
      return left(
        CreateNoteFailure(
          e.message ?? 'An error occurred',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        CreateNoteFailure(
          'An unexpected error occurred',
          stackTrace: st,
        ),
      );
    }
  }
}
