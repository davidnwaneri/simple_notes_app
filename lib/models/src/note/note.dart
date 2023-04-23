// 📦 Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required String body,
    /// The last time the note was modified.
    ///
    /// This field is made nullable to avoid passing it
    /// to a [Note] object when creating a new note.
    ///
    /// It is also ignored when `toJson` is called to avoid
    /// passing it to the backend, since the backend will
    /// generate this field.
    @JsonKey(includeToJson: false) String? lastModified,

    /// A unique identifier for the note.
    ///
    /// This id will be initially null but
    /// will be assigned at the backend....So fetching
    /// notes from the backend will have a non-null id.
    String? id,
    @JsonKey(fromJson: titleFromJson) String? title,
  }) = _Note;

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);
}

String? titleFromJson(String? title) {
  if (title == null || title.isEmpty) return null;
  return title;
}
