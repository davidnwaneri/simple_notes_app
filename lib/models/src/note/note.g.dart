// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      body: json['body'] as String,
      lastModified: json['lastModified'] as String?,
      ownerId: json['ownerId'] as String?,
      id: json['id'] as String?,
      title: _titleFromJson(json['title'] as String?),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'body': instance.body,
      'ownerId': instance.ownerId,
      'id': instance.id,
      'title': instance.title,
    };
