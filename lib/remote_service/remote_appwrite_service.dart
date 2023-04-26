import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:simple_notes_app/core/extensions.dart';
import 'package:simple_notes_app/models/src/note/note.dart';

const _databaseId = String.fromEnvironment('APPWRITE_NOTE_DATABASE_ID');
const _collectionId = String.fromEnvironment('APPWRITE_NOTE_COLLECTION_ID');

class RemoteAppWriteService {
  RemoteAppWriteService({
    required Databases databases,
  }) : _databases = databases;

  final Databases _databases;

  Future<List<Note>> fetchNotes({required String ownerId}) async {
    final res = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _collectionId,
      queries: [Query.equal('ownerId', ownerId)],
    );
    return _convertDocumentsToNotes(res.documents);
  }

  Future<Note> createNote(Note note) async {
    return _convertDocumentToNote(
      await _databases.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: note.id!,
        data: note.toJson(),
      ),
    );
  }

  Future<Note> editNote(Note note) async {
    'Note ID: ${note.id}'.log();
    return _convertDocumentToNote(
      await _databases.updateDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: note.id!,
        data: note.toJson(),
      ),
    );
  }

  Future<void> deleteNote(Note note) async {
    await _databases.deleteDocument(
      databaseId: _databaseId,
      collectionId: _collectionId,
      documentId: note.id!,
    );
  }

  List<Note> _convertDocumentsToNotes(List<models.Document> documents) {
    if (documents.isEmpty) return const [];
    return documents.map(_convertDocumentToNote).toList();
  }

  Note _convertDocumentToNote(models.Document doc) {
    final lastModified = DateTime.parse(doc.$updatedAt);
    final timeAgo = lastModified.toTimeAgo();
    return Note.fromJson(doc.data).copyWith(
      lastModified: timeAgo,
    );
  }
}
