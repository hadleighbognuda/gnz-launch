#!/bin/bash

# Build script for Glider Tow Flutter App
# This script provides different build options for different environments

set -e

echo "🚁 Glider Tow Flutter App Build Script"
echo "======================================"

# Check if we're in a Docker container
if [ -f /.dockerenv ]; then
    echo "📦 Running in Docker container"
    BUILD_ENV="docker"
else
    echo "💻 Running on host system"
    BUILD_ENV="host"
fi

# Function to build Flutter app
build_flutter_app() {
    echo "🔨 Building Flutter app..."
    
    cd flutter_app
    
    # Check if Flutter is installed
    if ! command -v flutter &> /dev/null; then
        echo "❌ Flutter not found. Please install Flutter first."
        echo "Visit: https://flutter.dev/docs/get-started/install"
        exit 1
    fi
    
    echo "📱 Flutter version:"
    flutter --version
    
    echo "🔧 Getting dependencies..."
    flutter pub get
    
    echo "🌐 Enabling web support..."
    flutter config --enable-web
    
    echo "🌐 Building for web..."
    flutter build web
    
    echo "✅ Flutter app built successfully!"
    echo "📁 Build output: flutter_app/build/web/"
}

# Function to run Flutter app
run_flutter_app() {
    echo "🚀 Running Flutter app..."
    
    cd flutter_app
    
    if ! command -v flutter &> /dev/null; then
        echo "❌ Flutter not found. Please install Flutter first."
        exit 1
    fi
    
    echo "🔧 Getting dependencies..."
    flutter pub get
    
    echo "🌐 Enabling web support..."
    flutter config --enable-web
    
    echo "🌐 Starting Flutter web server..."
    echo "📱 App will be available at: http://localhost:8080"
    flutter run -d web-server --web-port 8080
}

# Function to validate project structure
validate_project() {
    echo "🔍 Validating Flutter project structure..."
    
    required_files=(
        "flutter_app/pubspec.yaml"
        "flutter_app/lib/main.dart"
        "flutter_app/lib/models/flight_registration.dart"
        "flutter_app/lib/providers/flight_provider.dart"
        "flutter_app/lib/screens/home_screen.dart"
        "flutter_app/lib/screens/registration_screen.dart"
        "flutter_app/lib/widgets/custom_text_field.dart"
        "flutter_app/lib/widgets/section_header.dart"
        "flutter_app/lib/widgets/registration_summary_card.dart"
        "flutter_app/lib/widgets/location_capture_widget.dart"
    )
    
    for file in "${required_files[@]}"; do
        if [ -f "$file" ]; then
            echo "   ✓ $file"
        else
            echo "   ❌ $file (missing)"
            exit 1
        fi
    done
    
    echo "✅ Flutter project structure validation passed!"
}

# Function to clean Flutter build
clean_flutter() {
    echo "🧹 Cleaning Flutter build..."
    
    cd flutter_app
    
    if ! command -v flutter &> /dev/null; then
        echo "❌ Flutter not found. Please install Flutter first."
        exit 1
    fi
    
    flutter clean
    flutter pub get
    
    echo "✅ Flutter build cleaned!"
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  build     Build the Flutter app for web"
    echo "  run       Run the Flutter app in development mode"
    echo "  validate  Validate Flutter project structure"
    echo "  clean     Clean Flutter build cache"
    echo "  docker    Build and run in Docker container"
    echo "  docker-dev Run in Docker with hot reload"
    echo "  help      Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build"
    echo "  $0 run"
    echo "  $0 validate"
    echo "  $0 docker"
    echo "  $0 docker-dev"
}

# Main script logic
case "${1:-build}" in
    "build")
        validate_project
        build_flutter_app
        ;;
    "run")
        validate_project
        run_flutter_app
        ;;
    "validate")
        validate_project
        ;;
    "clean")
        clean_flutter
        ;;
    "docker")
        echo "🐳 Building Docker container..."
        docker-compose build
        echo "🚀 Starting Docker container..."
        docker-compose up -d
        echo "✅ Docker container started!"
        echo "🌐 App available at: http://localhost:8080"
        echo "💡 To view logs: docker-compose logs -f"
        echo "💡 To stop: docker-compose down"
        ;;
    "docker-dev")
        echo "🐳 Building Docker container for development..."
        docker-compose build
        echo "🚀 Starting Docker container with hot reload..."
        docker-compose --profile dev up -d flutter-dev
        echo "✅ Development container started!"
        echo "🌐 App available at: http://localhost:8080"
        echo "🔥 Hot reload enabled for development"
        echo "💡 To view logs: docker-compose logs -f flutter-dev"
        echo "💡 To stop: docker-compose down"
        ;;
    "help"|"-h"|"--help")
        show_help
        ;;
    *)
        echo "❌ Unknown option: $1"
        show_help
        exit 1
        ;;
esac

echo ""
echo "🎉 Script completed successfully!"
