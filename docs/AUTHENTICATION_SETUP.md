# Laravel Sanctum Authentication Setup

This document explains how to set up and use Laravel Sanctum authentication in the Glider Tow Registration Flutter app.

## Overview

The app now includes complete Laravel Sanctum authentication integration, allowing users to:
- Login with email and password
- Store authentication tokens securely
- Access protected API endpoints
- Logout and revoke tokens

## Architecture

### Models
- `User`: Represents user data from Laravel
- `AuthToken`: Contains authentication token and user data
- `LoginRequest`: Request payload for login

### Services
- `AuthService`: Handles API communication with Laravel Sanctum endpoints
- Uses Dio HTTP client for robust API communication
- Automatic token management and refresh

### Providers
- `AuthProvider`: State management for authentication
- Handles login/logout state
- Secure token storage using flutter_secure_storage

### Screens
- `LoginScreen`: Email/password login form
- `AuthWrapper`: Routes between login and main app based on auth state
- Updated `HomeScreen`: Shows user info and logout option

## Setup Instructions

### 1. Laravel Backend Setup

First, ensure your Laravel app has Sanctum properly configured:

```bash
# Install Sanctum
composer require laravel/sanctum

# Publish and run migrations
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
php artisan migrate
```

### 2. Laravel API Routes

Add these routes to your Laravel `routes/api.php`:

```php
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

// Token-based authentication route
Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required|email',
        'password' => 'required',
        'device_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    return $user->createToken($request->device_name)->plainTextToken;
});

// Protected user route
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Token revocation route
Route::post('/sanctum/token/revoke', function (Request $request) {
    $request->user()->currentAccessToken()->delete();
    return response()->json(['message' => 'Token revoked']);
})->middleware('auth:sanctum');
```

### 3. Laravel User Model

Ensure your User model uses the HasApiTokens trait:

```php
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;
    // ... rest of your model
}
```

### 4. Flutter Configuration

Update the API configuration in `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // Replace with your actual Laravel app URL
  static const String baseUrl = 'https://your-laravel-app.com/api';
  
  // ... rest of configuration
}
```

### 5. Install Flutter Dependencies

Run the following command to install the required dependencies:

```bash
cd flutter_app
flutter pub get
```

### 6. Generate Model Files

Run the build runner to generate the JSON serialization files:

```bash
flutter packages pub run build_runner build
```

## Usage

### Login Flow

1. User opens the app
2. If not authenticated, they see the login screen
3. User enters email and password
4. App sends request to `/sanctum/token` endpoint
5. On success, token is stored securely and user is redirected to main app
6. Token is automatically included in subsequent API requests

### Logout Flow

1. User taps the account menu in the app bar
2. Selects "Logout" option
3. App sends request to `/sanctum/token/revoke` endpoint
4. Local authentication data is cleared
5. User is redirected to login screen

### Token Management

- Tokens are stored securely using `flutter_secure_storage`
- Tokens are automatically included in API requests via Dio interceptors
- Token validation happens on each protected API call
- Invalid/expired tokens trigger automatic logout

## Security Features

### Secure Storage
- Authentication tokens stored using `flutter_secure_storage`
- Tokens encrypted on device storage
- Automatic cleanup on logout

### Token Validation
- Automatic token validation on API calls
- 401 responses trigger automatic logout
- Token expiration handling

### Input Validation
- Email format validation
- Password length requirements
- Form validation before API calls

## API Endpoints

The app communicates with these Laravel Sanctum endpoints:

- `POST /api/sanctum/token` - Login and get token
- `GET /api/user` - Get current user data
- `POST /api/sanctum/token/revoke` - Revoke current token

## Error Handling

The app handles various error scenarios:

- Invalid credentials (401)
- Network errors
- Validation errors (422)
- Server errors (500+)

Error messages are displayed to users via SnackBar notifications.

## Development Notes

### Debug Mode
- Extensive logging in debug mode
- Token information logged (truncated for security)
- API request/response logging

### Testing
- Authentication state can be easily mocked for testing
- Provider pattern allows for easy unit testing
- Dio interceptors can be tested independently

## Future Enhancements

Potential improvements to consider:

1. **Token Refresh**: Implement automatic token refresh before expiration
2. **Biometric Authentication**: Add fingerprint/face ID support
3. **Remember Me**: Option to stay logged in longer
4. **Multi-Factor Authentication**: Support for 2FA
5. **Offline Support**: Cache user data for offline use
6. **Push Notifications**: Notify users of important updates

## Troubleshooting

### Common Issues

1. **"Invalid email or password"**: Check Laravel user credentials
2. **Network errors**: Verify Laravel app URL in ApiConfig
3. **Token not working**: Ensure Sanctum is properly configured in Laravel
4. **Build errors**: Run `flutter pub get` and `flutter packages pub run build_runner build`

### Debug Steps

1. Check Flutter debug console for error messages
2. Verify Laravel logs for API request issues
3. Test API endpoints directly with tools like Postman
4. Ensure CORS is configured properly in Laravel

## Support

For issues or questions regarding the authentication implementation, refer to:
- Laravel Sanctum documentation: https://laravel.com/docs/12.x/sanctum
- Flutter documentation: https://flutter.dev/docs
- Dio HTTP client: https://pub.dev/packages/dio
