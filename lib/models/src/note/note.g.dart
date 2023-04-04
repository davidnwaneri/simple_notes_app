// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      body: json['body'] as String,
      lastModified: json['lastModified'] as String,
      id: json['id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) =>
    <String, dynamic>{
      'body': instance.body,
      'lastModified': instance.lastModified,
      'id': instance.id,
      'title': instance.title,
    };
