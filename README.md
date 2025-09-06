# Glider Tow Registration Flutter App

A simple and user-friendly Flutter application for registering flight details for glider tow operations. Designed specifically for aged users with large, clear interfaces and intuitive navigation. Runs on web, iOS, and desktop platforms.

## Features

- **Simple Registration Form**: Easy-to-use form for entering flight details
- **Clear UI Design**: Large fonts, high contrast, and intuitive layout for aged users
- **Flight Data Management**: Store and manage tow plane and glider registration details
- **Pilot ID Validation**: 4-digit numeric pilot ID validation
- **Recent Registrations**: View recent flight registrations
- **Docker Support**: Build and run in WSL/Windows environment
- **GPS Location Tracking**: Optional location capture for flight details
- **Cross-Platform**: Runs on web, iOS, and desktop
- **Hot Reload**: Fast development with instant updates

## App Structure

### Main Screens
1. **Home Screen**: Welcome screen with option to start new registration
2. **Registration Form**: Detailed form for entering flight information
3. **Confirmation**: Success/error feedback after registration

### Data Fields
- **Tow Plane Registration**: Aircraft registration ID
- **Tow Plane Pilot Name**: Full name of the tow plane pilot
- **Glider Registration**: Glider aircraft registration ID
- **Primary Pilot ID**: 4-digit numeric ID (required for billing)
- **Secondary Pilot ID**: 4-digit numeric ID (optional)

## UI Design Principles

### Accessibility Features
- **Large Fonts**: Minimum 18pt font size throughout the app
- **High Contrast**: Dark text on light backgrounds for better readability
- **Large Touch Targets**: Minimum 44pt touch areas for easy interaction
- **Clear Visual Hierarchy**: Organized sections with clear headings
- **VoiceOver Support**: Full accessibility support for screen readers
- **Dynamic Type**: Support for system text scaling

### Color Scheme
- **Primary Background**: White (#FFFFFF)
- **Secondary Background**: Light Gray (#F5F5F5)
- **Primary Text**: Dark Gray (#333333)
- **Primary Button**: Blue (#007AFF)
- **Error Text**: Red (#FF3B30)
- **Success Text**: Green (#34C759)

## Building and Running

### Prerequisites
- Flutter SDK (for local development)
- Docker Desktop (for containerized development)
- WSL2 (for Windows users)
- Modern web browser (for web version)

### Using Docker (Recommended for WSL/Windows)

1. **Build the Docker container**:
   ```bash
   ./build.sh docker
   ```

2. **Enter the container**:
   ```bash
   docker-compose exec ios-dev bash
   ```

3. **Validate the project**:
   ```bash
   ./build.sh validate
   ```

### Using Flutter (Local Development)

1. **Install Flutter**:
   ```bash
   # Follow instructions at https://flutter.dev/docs/get-started/install
   ```

2. **Run the app**:
   ```bash
   ./build.sh run
   ```

3. **Build for production**:
   ```bash
   ./build.sh build
   ```


### Build Script Options

The `build.sh` script provides several options:

- `./build.sh build` - Build the Flutter app for web
- `./build.sh run` - Run the Flutter app in development mode
- `./build.sh validate` - Validate Flutter project structure
- `./build.sh clean` - Clean Flutter build cache
- `./build.sh docker` - Build and run in Docker container
- `./build.sh docker-dev` - Run in Docker with hot reload
- `./build.sh help` - Show help message

## Project Structure

```
flutter_app/
├── lib/
│   ├── main.dart                    # Main app entry point
│   ├── models/
│   │   └── flight_registration.dart # Data models
│   ├── providers/
│   │   └── flight_provider.dart     # State management
│   ├── screens/
│   │   ├── home_screen.dart         # Home screen
│   │   └── registration_screen.dart # Registration form
│   ├── widgets/
│   │   ├── custom_text_field.dart   # Custom input fields
│   │   ├── section_header.dart      # Section headers
│   │   ├── registration_summary_card.dart # Registration cards
│   │   └── location_capture_widget.dart   # GPS location widget
│   └── utils/
│       └── constants.dart           # App constants
├── assets/
│   └── images/                      # App images and icons
├── test/                            # Unit tests
├── pubspec.yaml                     # Flutter dependencies
├── Dockerfile                       # Docker configuration
├── docker-compose.yml               # Docker Compose setup
├── build.sh                         # Build script
└── README.md                        # This file
```

## Technical Details

### Flutter Components
- **MaterialApp**: Main app structure with theming
- **Scaffold**: Screen layout with app bar and body
- **Form**: Registration form with validation
- **CustomTextField**: Accessible text input components
- **SectionHeader**: Clear section organization
- **SnackBar**: Success/error feedback

### Data Model
- **FlightRegistration**: Main data structure with GPS support
- **FlightProvider**: State management using Provider pattern
- **Validation**: Built-in form validation
- **Persistence**: SharedPreferences for local storage

### Development Environment
- **Flutter Version**: 3.0.0+
- **Dart Version**: Dart 3.0+
- **Framework**: Flutter
- **Architecture**: Provider pattern with MVVM
- **Platforms**: Web, iOS, Desktop

## Future Enhancements

- **Cloud Sync**: Firebase/Cloud Firestore integration
- **Export Features**: PDF/CSV export of registrations
- **Search and Filter**: Find specific registrations
- **Offline Support**: Work without internet connection
- **Backup/Restore**: Data backup functionality
- **Push Notifications**: Flight reminders and updates
- **Advanced GPS**: Flight path tracking and recording
- **Multi-language Support**: Internationalization

## Support

For questions or issues with the app, please refer to the project documentation or contact the development team.

## License

This project is developed for glider tow operations and is intended for internal use.
