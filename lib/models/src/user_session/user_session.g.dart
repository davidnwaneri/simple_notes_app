// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserSession _$$_UserSessionFromJson(Map<String, dynamic> json) =>
    _$_UserSession(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      createdAt: json['createdAt'] as String,
      expireAt: json['expireAt'] as String,
    );

Map<String, dynamic> _$$_UserSessionToJson(_$_UserSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'expireAt': instance.expireAt,
    };
