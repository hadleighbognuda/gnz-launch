class ApiConfig {
  // Replace with your actual Laravel app URL
  static const String baseUrl = 'https://your-laravel-app.com/api';
  
  // API Endpoints
  static const String loginEndpoint = '/sanctum/token';
  static const String logoutEndpoint = '/sanctum/token/revoke';
  static const String userEndpoint = '/user';
  
  // Request timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
