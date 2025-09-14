# ASDF Setup Guide for Glider Tow Registration App

## 🛠️ **ASDF Configuration**

This project uses ASDF (version manager) to manage Flutter and Dart dependencies for consistent development environments.

## 📋 **Required Dependencies**

The `.tool-versions` file specifies:
- **Flutter**: 3.24.5
- **Dart**: 3.5.0

## 🚀 **Setup Instructions**

### **1. Install ASDF (if not already installed)**

#### **On Ubuntu/Debian:**
```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
source ~/.bashrc
```

#### **On macOS:**
```bash
brew install asdf
echo -e '\n. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.bash_profile
source ~/.bash_profile
```

### **2. Install ASDF Plugins**

```bash
# Install Flutter plugin
asdf plugin add flutter

# Install Dart plugin  
asdf plugin add dart
```

### **3. Install Dependencies**

```bash
# Navigate to project directory
cd /path/to/gnz-launch

# Install Flutter and Dart versions specified in .tool-versions
asdf install
```

### **4. Verify Installation**

```bash
# Check Flutter version
flutter --version

# Check Dart version
dart --version

# Verify Flutter doctor
flutter doctor
```

## 🔧 **Project Setup**

### **Enable Web Support**

After installing Flutter via ASDF:

```bash
# Navigate to Flutter app directory
cd flutter_app

# Enable web platform
flutter create . --platforms web

# Get dependencies
flutter pub get

# Enable web support
flutter config --enable-web
```

### **Run the App**

```bash
# Run in development mode
flutter run -d web-server --web-port 8080

# Or use the build script
./build.sh run
```

## 🐳 **Docker Integration**

The Docker setup automatically installs Flutter, but you can also use ASDF in Docker:

### **Dockerfile with ASDF:**
```dockerfile
FROM ubuntu:22.04

# Install ASDF dependencies
RUN apt-get update && apt-get install -y \
    curl git unzip xz-utils zip libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install ASDF
RUN git clone https://github.com/asdf-vm/asdf.git /opt/asdf --branch v0.14.0
ENV PATH="/opt/asdf/bin:/opt/asdf/shims:$PATH"

# Install ASDF plugins
RUN asdf plugin add flutter && asdf plugin add dart

WORKDIR /app

# Copy project files
COPY . /app/

# Install dependencies
RUN asdf install

# Enable web support
RUN flutter config --enable-web

# Get Flutter dependencies
RUN cd flutter_app && flutter pub get

# Build the app
RUN cd flutter_app && flutter build web
```

## 📝 **ASDF Commands**

### **Common ASDF Commands:**
```bash
# List installed versions
asdf list

# List available versions
asdf list all flutter
asdf list all dart

# Install specific version
asdf install flutter 3.24.5
asdf install dart 3.5.0

# Set global version
asdf global flutter 3.24.5
asdf global dart 3.5.0

# Set local version (for this project)
asdf local flutter 3.24.5
asdf local dart 3.5.0

# Update plugins
asdf plugin update --all

# Reshim (after installing new tools)
asdf reshim
```

## 🔍 **Troubleshooting**

### **Common Issues:**

#### **ASDF not found:**
```bash
# Reload shell configuration
source ~/.bashrc
# or
source ~/.bash_profile
```

#### **Flutter not found after ASDF install:**
```bash
# Reshim ASDF
asdf reshim

# Check PATH
echo $PATH
```

#### **Web platform not enabled:**
```bash
# Enable web support
flutter config --enable-web

# Verify web support
flutter config
```

#### **Dependencies not found:**
```bash
# Get Flutter dependencies
cd flutter_app
flutter pub get

# Clean and rebuild
flutter clean
flutter pub get
```

## 🎯 **Benefits of ASDF**

- ✅ **Version Consistency** - Same versions across all environments
- ✅ **Easy Switching** - Switch between Flutter/Dart versions easily
- ✅ **Team Collaboration** - Everyone uses the same versions
- ✅ **CI/CD Friendly** - Reproducible builds
- ✅ **Multiple Languages** - Manage Flutter, Dart, Node.js, etc.

## 📚 **Additional Resources**

- [ASDF Documentation](https://asdf-vm.com/)
- [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- [Dart Installation Guide](https://dart.dev/get-dart)

The ASDF configuration ensures that all developers working on this project use the same Flutter and Dart versions, preventing version-related issues and ensuring consistent behavior across different environments.
