# ${{ values.appName }}

A Flutter application created from the Devweave Flutter boilerplate.

## Project Information

- **App Name**: ${{ values.appName }}
- **Package Name**: `${{ values.packageName }}`
- **Target Platforms**: {{ values.platforms | join(', ') }}

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
{% if 'android' in values.platforms %}
- Android Studio / Android SDK (for Android development)
{% endif %}
{% if 'ios' in values.platforms %}
- Xcode (for iOS development, macOS only)
{% endif %}

### Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/Devweave/${{ values.repoName }}.git
   cd ${{ values.repoName }}
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Available Platforms

This project has been configured for the following platforms:
{% for platform in values.platforms %}
- **{{ platform | title }}**: Ready for development
{% endfor %}

### Project Structure

```
${{ values.repoName }}/
├── lib/                 # Main application code
│   ├── main.dart       # App entry point
│   └── ...
├── test/               # Unit and widget tests
{% if 'android' in values.platforms %}
├── android/            # Android-specific code
{% endif %}
{% if 'ios' in values.platforms %}
├── ios/                # iOS-specific code
{% endif %}
{% if 'web' in values.platforms %}
├── web/                # Web-specific code
{% endif %}
{% if 'windows' in values.platforms %}
├── windows/            # Windows-specific code
{% endif %}
{% if 'linux' in values.platforms %}
├── linux/              # Linux-specific code
{% endif %}
{% if 'macos' in values.platforms %}
├── macos/              # macOS-specific code
{% endif %}
└── pubspec.yaml        # Project dependencies and metadata
```

### Development

To run the app on a specific platform:

{% if 'android' in values.platforms %}
```bash
# Android
flutter run -d android
```
{% endif %}

{% if 'ios' in values.platforms %}
```bash
# iOS (macOS only)
flutter run -d ios
```
{% endif %}

{% if 'web' in values.platforms %}
```bash
# Web
flutter run -d web-server
```
{% endif %}

{% if 'windows' in values.platforms %}
```bash
# Windows
flutter run -d windows
```
{% endif %}

{% if 'linux' in values.platforms %}
```bash
# Linux
flutter run -d linux
```
{% endif %}

{% if 'macos' in values.platforms %}
```bash
# macOS
flutter run -d macos
```
{% endif %}

### Building for Release

{% if 'android' in values.platforms %}
#### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```
{% endif %}

{% if 'ios' in values.platforms %}
#### iOS
```bash
flutter build ios --release
```
{% endif %}

{% if 'web' in values.platforms %}
#### Web
```bash
flutter build web --release
```
{% endif %}

{% if 'windows' in values.platforms %}
#### Windows
```bash
flutter build windows --release
```
{% endif %}

{% if 'linux' in values.platforms %}
#### Linux
```bash
flutter build linux --release
```
{% endif %}

{% if 'macos' in values.platforms %}
#### macOS
```bash
flutter build macos --release
```
{% endif %}

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Generated with ❤️ using [Backstage](https://backstage.io/) and the Flutter Template
