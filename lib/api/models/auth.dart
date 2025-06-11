import 'dart:convert';

/*
{
  "user_id": "string",
  "access_token": "string",
  "token_type": "string",
  "expires_in": 60,
  "expires_at": 0
}
*/

class Auth {
  /// 유저 ID
  final String uid;

  /// 토큰
  final String token;

  /// 토큰 타입
  final String tokenType;

  /// 토큰 만료 시간
  final int expireIn;

  /// 토큰 만료 기한
  final int expiresAt;
  Auth({
    required this.uid,
    required this.token,
    required this.tokenType,
    required this.expireIn,
    required this.expiresAt,
  });

  Auth copyWith({
    String? uid,
    String? token,
    String? tokenType,
    int? expireIn,
    int? expiresAt,
  }) {
    return Auth(
      uid: uid ?? this.uid,
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      expireIn: expireIn ?? this.expireIn,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': uid,
      'access_token': token,
      'token_type': tokenType,
      'expires_in': expireIn,
      'expires_at': expiresAt,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      uid: map['user_id'] as String,
      token: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expireIn: map['expires_in'] as int,
      expiresAt: map['expires_at'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) =>
      Auth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Auth(uid: $uid, token: $token, tokenType: $tokenType, expireIn: $expireIn, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.token == token &&
        other.tokenType == tokenType &&
        other.expireIn == expireIn &&
        other.expiresAt == expiresAt;
  }
}
