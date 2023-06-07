// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserSession _$UserSessionFromJson(Map<String, dynamic> json) {
  return _UserSession.fromJson(json);
}

/// @nodoc
mixin _$UserSession {
  String get sessionId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get expireAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserSessionCopyWith<UserSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSessionCopyWith<$Res> {
  factory $UserSessionCopyWith(
          UserSession value, $Res Function(UserSession) then) =
      _$UserSessionCopyWithImpl<$Res, UserSession>;
  @useResult
  $Res call(
      {String sessionId, String userId, String createdAt, String expireAt});
}

/// @nodoc
class _$UserSessionCopyWithImpl<$Res, $Val extends UserSession>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? expireAt = null,
  }) {
    return _then(_value.copyWith(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserSessionCopyWith<$Res>
    implements $UserSessionCopyWith<$Res> {
  factory _$$_UserSessionCopyWith(
          _$_UserSession value, $Res Function(_$_UserSession) then) =
      __$$_UserSessionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String sessionId, String userId, String createdAt, String expireAt});
}

/// @nodoc
class __$$_UserSessionCopyWithImpl<$Res>
    extends _$UserSessionCopyWithImpl<$Res, _$_UserSession>
    implements _$$_UserSessionCopyWith<$Res> {
  __$$_UserSessionCopyWithImpl(
      _$_UserSession _value, $Res Function(_$_UserSession) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? expireAt = null,
  }) {
    return _then(_$_UserSession(
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      expireAt: null == expireAt
          ? _value.expireAt
          : expireAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserSession implements _UserSession {
  const _$_UserSession(
      {required this.sessionId,
      required this.userId,
      required this.createdAt,
      required this.expireAt});

  factory _$_UserSession.fromJson(Map<String, dynamic> json) =>
      _$$_UserSessionFromJson(json);

  @override
  final String sessionId;
  @override
  final String userId;
  @override
  final String createdAt;
  @override
  final String expireAt;

  @override
  String toString() {
    return 'UserSession(sessionId: $sessionId, userId: $userId, createdAt: $createdAt, expireAt: $expireAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserSession &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expireAt, expireAt) ||
                other.expireAt == expireAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, sessionId, userId, createdAt, expireAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserSessionCopyWith<_$_UserSession> get copyWith =>
      __$$_UserSessionCopyWithImpl<_$_UserSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserSessionToJson(
      this,
    );
  }
}

abstract class _UserSession implements UserSession {
  const factory _UserSession(
      {required final String sessionId,
      required final String userId,
      required final String createdAt,
      required final String expireAt}) = _$_UserSession;

  factory _UserSession.fromJson(Map<String, dynamic> json) =
      _$_UserSession.fromJson;

  @override
  String get sessionId;
  @override
  String get userId;
  @override
  String get createdAt;
  @override
  String get expireAt;
  @override
  @JsonKey(ignore: true)
  _$$_UserSessionCopyWith<_$_UserSession> get copyWith =>
      throw _privateConstructorUsedError;
}
