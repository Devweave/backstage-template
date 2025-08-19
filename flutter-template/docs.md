# Flutter Backstage Template

This Backstage template creates a Flutter project from the Devweave Flutter boilerplate repository with customizable configuration.

## Features

- **Cross-platform Flutter app**: Supports Android, iOS, Web, Windows, Linux, and macOS
- **Customizable configuration**: Set app name, package name, and target platforms
- **Automated setup**: Clones boilerplate, renames app, configures platforms, and creates GitHub repository
- **Integrated with Backstage**: Automatic registration in the service catalog

## Template Workflow

1. **Fetch Boilerplate**: Clones the Flutter boilerplate from `https://github.com/Devweave/flutter-boilerplate`
2. **Clean Git History**: Removes existing `.git` directory and reinitializes
3. **Install Rename Package**: Activates the Flutter `rename` package globally
4. **Rename Application**: Updates the app display name using the rename package
5. **Set Package Name**: Updates the Flutter package/bundle identifier
6. **Configure Platforms**: Removes unselected platform directories
7. **Create GitHub Repository**: Creates a new repository and pushes the code
8. **Register in Catalog**: Adds the new service to the Backstage catalog

## Input Parameters

### App Configuration
- **App Display Name**: User-friendly name for the Flutter app
- **Package/Bundle ID**: Reverse domain notation identifier (e.g., `com.example.myapp`)
- **Target Platforms**: Select from Android, iOS, Web, Windows, Linux, macOS
- **Repository Name**: Name for the GitHub repository

### Repository Location
- **Repository URL**: GitHub repository location (restricted to Devweave organization)

## Generated Files

The template generates several files in the output:
- `catalog-info.yaml`: Backstage catalog registration
- `README.md`: Project documentation with platform-specific instructions
- `.gitignore`: Flutter-specific git ignore rules

## Usage

1. Navigate to the Backstage Software Templates page
2. Select "Flutter App Template"
3. Fill in the required parameters:
   - App name (e.g., "My Flutter App")
   - Package name (e.g., "com.mycompany.myapp")
   - Select target platforms
   - Choose repository name
4. Click "Create" to scaffold the project

## Output

After successful execution, you'll receive:
- **Repository Link**: Direct link to the created GitHub repository
- **Catalog Link**: Link to view the service in the Backstage catalog
- **Summary**: Display of configured app name, package name, and platforms

## Requirements

- Flutter SDK installed in the Backstage environment
- Access to the Devweave GitHub organization
- `rename` Flutter package available for installation

## Platform-Specific Notes

### Android
- Requires Android SDK for development
- Generates APK and App Bundle for release

### iOS
- Requires Xcode (macOS only)
- Generates IPA for App Store distribution

### Web
- No additional requirements
- Generates web assets for deployment

### Desktop (Windows/Linux/macOS)
- Platform-specific development tools may be required
- Generates native executables

## Troubleshooting

### Common Issues

1. **Rename package not found**: Ensure Flutter is properly installed and `pub global activate rename` works
2. **Platform removal fails**: Check that the boilerplate contains all expected platform directories
3. **GitHub creation fails**: Verify repository permissions and naming conventions

### Support

For issues with this template, please check:
1. Flutter boilerplate repository: https://github.com/Devweave/flutter-boilerplate
2. Backstage template repository: https://github.com/Devweave/backstage-template
3. Main Backstage instance: https://github.com/Devweave/backstage
