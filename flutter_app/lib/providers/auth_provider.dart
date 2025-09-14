import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../models/user.dart';
import '../models/auth_token.dart';
import '../services/auth_service.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _token;
  String? _errorMessage;

  AuthStatus get status => _status;
  User? get user => _user;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;

  AuthProvider() {
    _initializeAuth();
  }

  /// Initialize authentication state
  Future<void> _initializeAuth() async {
    _setStatus(AuthStatus.loading);
    
    try {
      // Check if user is already authenticated
      final isAuth = await _authService.isAuthenticated();
      if (isAuth) {
        await _loadStoredAuthData();
        _setStatus(AuthStatus.authenticated);
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Auth initialization error: $e');
      }
      _setStatus(AuthStatus.unauthenticated);
    }
  }

  /// Login with email and password
  Future<bool> login(String email, String password, String deviceName) async {
    _setStatus(AuthStatus.loading);
    _clearError();

    try {
      final authToken = await _authService.login(email, password, deviceName);
      
      _user = authToken.user;
      _token = authToken.token;
      
      // Store auth data securely
      await _storeAuthData(authToken);
      
      _setStatus(AuthStatus.authenticated);
      
      if (kDebugMode) {
        print('Login successful: ${_user?.email}');
      }
      
      return true;
    } catch (e) {
      _setError(e.toString());
      _setStatus(AuthStatus.error);
      
      if (kDebugMode) {
        print('Login failed: $e');
      }
      
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    _setStatus(AuthStatus.loading);
    
    try {
      await _authService.logout();
      await _clearStoredAuthData();
      
      _user = null;
      _token = null;
      _clearError();
      
      _setStatus(AuthStatus.unauthenticated);
      
      if (kDebugMode) {
        print('Logout successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      // Even if logout fails on server, clear local data
      _user = null;
      _token = null;
      _setStatus(AuthStatus.unauthenticated);
    }
  }

  /// Store authentication data securely
  Future<void> _storeAuthData(AuthToken authToken) async {
    try {
      await _secureStorage.write(key: 'auth_token', value: authToken.token);
      await _secureStorage.write(
        key: 'user_data', 
        value: jsonEncode(authToken.user.toJson()),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error storing auth data: $e');
      }
    }
  }

  /// Load stored authentication data
  Future<void> _loadStoredAuthData() async {
    try {
      final token = await _secureStorage.read(key: 'auth_token');
      final userData = await _secureStorage.read(key: 'user_data');
      
      if (token != null && userData != null) {
        _token = token;
        _user = User.fromJson(jsonDecode(userData));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading stored auth data: $e');
      }
    }
  }

  /// Clear stored authentication data
  Future<void> _clearStoredAuthData() async {
    try {
      await _secureStorage.delete(key: 'auth_token');
      await _secureStorage.delete(key: 'user_data');
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing stored auth data: $e');
      }
    }
  }

  /// Set authentication status
  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  /// Set error message
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clear error message
  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Refresh user data
  Future<void> refreshUser() async {
    if (!isAuthenticated) return;
    
    try {
      final updatedUser = await _authService.getCurrentUser();
      _user = updatedUser;
      
      // Update stored user data
      await _secureStorage.write(
        key: 'user_data', 
        value: jsonEncode(updatedUser.toJson()),
      );
      
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error refreshing user data: $e');
      }
    }
  }
}
