// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String body,
    required String lastModified,

    /// A unique identifier for the note.
    ///
    /// This id will be initially null but
    /// will be assigned at the backend....So fetching
    /// notes from the backend will have a non-null id.
    String? id,
    String? title,
  }) = _Note;

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}
