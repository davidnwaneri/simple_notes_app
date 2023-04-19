import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

@freezed
class UserSession with _$UserSession {
  const factory UserSession({
    required String sessionId,
    required String userId,
    required String createdAt,
    required String expireAt,
  }) = _UserSession;

  factory UserSession.fromJson(Map<String, Object?> json) =>
      _$UserSessionFromJson(json);
}
