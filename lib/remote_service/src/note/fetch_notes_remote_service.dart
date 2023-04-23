// 📦 Package imports:
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:fpdart/fpdart.dart';

// 🌎 Project imports:
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/core/failure.dart';
import 'package:simple_notes_app/core/typedefs.dart';
import 'package:simple_notes_app/models/models.dart';
import 'package:simple_notes_app/remote_service/src/note/dummy_notes.dart';

mixin IFetchNotesRemoteService {
  FutureEitherNotes fetchNotes({required String ownerId});
}

class FetchNotesRemoteServiceWithAppWrite implements IFetchNotesRemoteService {
  const FetchNotesRemoteServiceWithAppWrite({
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
  FutureEitherNotes fetchNotes({required String ownerId}) async {
    try {
      final res = await _databases.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
        queries: [
          Query.equal('ownerId', ownerId),
        ],
      );
      final notes = _convertDocumentsToNotes(res.documents);
      return right(notes);
    } on AppwriteException catch (e, st) {
      return left(
        FetchingNotesFailure(
          e.message ?? 'An error occurred while fetching notes',
          stackTrace: st,
        ),
      );
    } catch (e, st) {
      return left(
        FetchingNotesFailure(
          'An unexpected error occurred while fetching notes',
          stackTrace: st,
        ),
      );
    }
  }

  List<Note> _convertDocumentsToNotes(List<models.Document> documents) {
    if (documents.isEmpty) return const [];
    return documents.map((d) {
      final lastModified = DateTime.parse(d.$updatedAt);
      final timeAgo = lastModified.toTimeAgo();
      return Note.fromJson(d.data).copyWith(
        lastModified: timeAgo,
      );
    }).toList();
  }
}

class DummyNoteService implements IFetchNotesRemoteService {
  @override
  FutureEitherNotes fetchNotes({required String ownerId}) async {
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
}
