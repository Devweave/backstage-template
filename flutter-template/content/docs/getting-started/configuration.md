# Configuration

Learn how to configure ${{ values.appName }}.

## API Keys

1. Copy the example file:
   ```bash
   cp api-keys.example.json api-keys.json
   ```

2. Edit `api-keys.json` with your actual API keys.

3. Never commit `api-keys.json` to version control.

## Environment Variables

Configure environment-specific settings in your API keys file.

## Platform Configuration

### Android
- Update `android/app/build.gradle` for app-specific settings
- Configure signing keys for release builds

### iOS
- Update `ios/Runner/Info.plist` for app permissions
- Configure signing in Xcode

## Learn More

- [Quick Start](quick-start.md)
- [Development Tools](../development/tools.md)
