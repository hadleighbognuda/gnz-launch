# Dockerfile for Flutter Development Environment
# This creates a container for Flutter development with web support

FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install ASDF
RUN git clone https://github.com/asdf-vm/asdf.git /opt/asdf --branch v0.18.0
ENV PATH="/opt/asdf/bin:/opt/asdf/shims:$PATH"

# Install ASDF plugins
RUN asdf plugin add flutter && asdf plugin add dart

WORKDIR /app

# Copy project files (including .tool-versions)
COPY . /app/

# Install Flutter and Dart versions from .tool-versions
RUN asdf install

RUN asdf current

# Enable Flutter web
RUN flutter config --enable-web

# Verify Flutter installation
RUN flutter doctor

# Get dependencies
RUN cd flutter_app && flutter pub get

# Build the app for web
RUN cd flutter_app && flutter build web

# Expose port for web server
EXPOSE 8080

# Default command - run the Flutter web app
CMD ["bash", "-c", "cd flutter_app && flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0"]
