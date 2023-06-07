// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Note _$NoteFromJson(Map<String, dynamic> json) {
  return _Note.fromJson(json);
}

/// @nodoc
mixin _$Note {
  String get body => throw _privateConstructorUsedError;

  /// The last time the note was modified.
  ///
  /// This field is made nullable to avoid passing it
  /// to a [Note] object when creating a new note.
  ///
  /// It is also ignored when `toJson` is called to avoid
  /// passing it to the backend, since the backend will
  /// generate this field.
  @JsonKey(includeToJson: false)
  String? get lastModified => throw _privateConstructorUsedError;

  /// The id of the user who created the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  String? get ownerId => throw _privateConstructorUsedError;

  /// A unique identifier for the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  ///
  /// This id will be initially null but
  /// will be assigned when sending to the backend....So fetching
  /// notes from the backend will have a non-null id.
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _titleFromJson)
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NoteCopyWith<Note> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) then) =
      _$NoteCopyWithImpl<$Res, Note>;
  @useResult
  $Res call(
      {String body,
      @JsonKey(includeToJson: false) String? lastModified,
      String? ownerId,
      String? id,
      @JsonKey(fromJson: _titleFromJson) String? title});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res, $Val extends Note>
    implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? body = null,
    Object? lastModified = freezed,
    Object? ownerId = freezed,
    Object? id = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$$_NoteCopyWith(_$_Note value, $Res Function(_$_Note) then) =
      __$$_NoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String body,
      @JsonKey(includeToJson: false) String? lastModified,
      String? ownerId,
      String? id,
      @JsonKey(fromJson: _titleFromJson) String? title});
}

/// @nodoc
class __$$_NoteCopyWithImpl<$Res> extends _$NoteCopyWithImpl<$Res, _$_Note>
    implements _$$_NoteCopyWith<$Res> {
  __$$_NoteCopyWithImpl(_$_Note _value, $Res Function(_$_Note) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? body = null,
    Object? lastModified = freezed,
    Object? ownerId = freezed,
    Object? id = freezed,
    Object? title = freezed,
  }) {
    return _then(_$_Note(
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      lastModified: freezed == lastModified
          ? _value.lastModified
          : lastModified // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: freezed == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Note implements _Note {
  const _$_Note(
      {required this.body,
      @JsonKey(includeToJson: false) this.lastModified,
      this.ownerId,
      this.id,
      @JsonKey(fromJson: _titleFromJson) this.title});

  factory _$_Note.fromJson(Map<String, dynamic> json) => _$$_NoteFromJson(json);

  @override
  final String body;

  /// The last time the note was modified.
  ///
  /// This field is made nullable to avoid passing it
  /// to a [Note] object when creating a new note.
  ///
  /// It is also ignored when `toJson` is called to avoid
  /// passing it to the backend, since the backend will
  /// generate this field.
  @override
  @JsonKey(includeToJson: false)
  final String? lastModified;

  /// The id of the user who created the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  @override
  final String? ownerId;

  /// A unique identifier for the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  ///
  /// This id will be initially null but
  /// will be assigned when sending to the backend....So fetching
  /// notes from the backend will have a non-null id.
  @override
  final String? id;
  @override
  @JsonKey(fromJson: _titleFromJson)
  final String? title;

  @override
  String toString() {
    return 'Note(body: $body, lastModified: $lastModified, ownerId: $ownerId, id: $id, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Note &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, body, lastModified, ownerId, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NoteCopyWith<_$_Note> get copyWith =>
      __$$_NoteCopyWithImpl<_$_Note>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NoteToJson(
      this,
    );
  }
}

abstract class _Note implements Note {
  const factory _Note(
      {required final String body,
      @JsonKey(includeToJson: false) final String? lastModified,
      final String? ownerId,
      final String? id,
      @JsonKey(fromJson: _titleFromJson) final String? title}) = _$_Note;

  factory _Note.fromJson(Map<String, dynamic> json) = _$_Note.fromJson;

  @override
  String get body;
  @override

  /// The last time the note was modified.
  ///
  /// This field is made nullable to avoid passing it
  /// to a [Note] object when creating a new note.
  ///
  /// It is also ignored when `toJson` is called to avoid
  /// passing it to the backend, since the backend will
  /// generate this field.
  @JsonKey(includeToJson: false)
  String? get lastModified;
  @override

  /// The id of the user who created the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  String? get ownerId;
  @override

  /// A unique identifier for the note.
  ///
  /// This is nullable to avoid passing it to a [Note] object
  /// when creating a new note in the widgets layer.
  ///
  /// This id will be initially null but
  /// will be assigned when sending to the backend....So fetching
  /// notes from the backend will have a non-null id.
  String? get id;
  @override
  @JsonKey(fromJson: _titleFromJson)
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_NoteCopyWith<_$_Note> get copyWith => throw _privateConstructorUsedError;
}
