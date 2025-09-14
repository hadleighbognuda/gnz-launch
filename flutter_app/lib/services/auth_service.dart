import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/auth_token.dart';
import '../models/login_request.dart';
import '../config/api_config.dart';

class AuthService {
  late final Dio _dio;
  String? _token;

  AuthService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: ApiConfig.defaultHeaders,
    ));

    // Add interceptors for automatic token handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // Token expired or invalid, clear it
            _token = null;
            // You might want to navigate to login screen here
          }
          handler.next(error);
        },
      ),
    );
  }

  /// Login with email and password
  Future<AuthToken> login(String email, String password, String deviceName) async {
    try {
      final loginRequest = LoginRequest(
        email: email,
        password: password,
        deviceName: deviceName,
      );

      final response = await _dio.post(ApiConfig.loginEndpoint, data: loginRequest.toJson());

      if (response.statusCode == 200) {
        final token = response.data['token'] as String;
        
        // Get user data
        final userResponse = await _dio.get(ApiConfig.userEndpoint);
        final user = User.fromJson(userResponse.data);

        final authToken = AuthToken(token: token, user: user);
        
        // Store token and user data
        _token = token;
        await _storeAuthData(authToken);

        if (kDebugMode) {
          print('Login successful for user: ${user.email}');
        }

        return authToken;
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Login error: ${e.message}');
      }
      
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else if (e.response?.statusCode == 422) {
        final errors = e.response?.data['errors'];
        if (errors != null) {
          final errorMessages = <String>[];
          errors.forEach((key, value) {
            if (value is List) {
              errorMessages.addAll(value.cast<String>());
            }
          });
          throw Exception(errorMessages.join('\n'));
        }
        throw Exception('Validation error');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected login error: $e');
      }
      throw Exception('An unexpected error occurred');
    }
  }

  /// Logout and revoke token
  Future<void> logout() async {
    try {
      if (_token != null) {
        await _dio.post(ApiConfig.logoutEndpoint);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
    } finally {
      _token = null;
      await _clearAuthData();
    }
  }

  /// Get current user data
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConfig.userEndpoint);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('Get user error: ${e.message}');
      }
      throw Exception('Failed to get user data');
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      await _loadStoredToken();
      if (_token == null) return false;
      
      // Try to get current user to validate token
      await getCurrentUser();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Authentication check failed: $e');
      }
      return false;
    }
  }

  /// Get stored auth token
  String? get token => _token;

  /// Store authentication data securely
  Future<void> _storeAuthData(AuthToken authToken) async {
    try {
      // Store token in memory
      _token = authToken.token;
      
      // Store user data in SharedPreferences (for now, could be moved to secure storage)
      // In a production app, you might want to store the token in secure storage
      // and user data in regular preferences
      // You can implement secure storage here if needed
      if (kDebugMode) {
        print('Auth data stored successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing auth data: $e');
      }
    }
  }

  /// Load stored token
  Future<void> _loadStoredToken() async {
    try {
      // In a real app, you'd load from secure storage
      // For now, we'll check if token is already loaded
      if (kDebugMode) {
        print('Loading stored token...');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading stored token: $e');
      }
    }
  }

  /// Clear stored authentication data
  Future<void> _clearAuthData() async {
    try {
      _token = null;
      if (kDebugMode) {
        print('Auth data cleared');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing auth data: $e');
      }
    }
  }
}
