import 'user.dart';

class AuthToken {
  final String token;
  final User user;

  const AuthToken({
    required this.token,
    required this.user,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  String toString() {
    return 'AuthToken(token: ${token.substring(0, 10)}..., user: $user)';
  }
}
