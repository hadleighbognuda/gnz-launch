class LoginRequest {
  final String email;
  final String password;
  final String deviceName;

  const LoginRequest({
    required this.email,
    required this.password,
    required this.deviceName,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      deviceName: json['device_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_name': deviceName,
    };
  }

  @override
  String toString() {
    return 'LoginRequest(email: $email, deviceName: $deviceName)';
  }
}
