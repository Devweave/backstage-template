# Flutter Template Integration Guide

This guide explains how to integrate the Flutter Backstage template into your Backstage instance.

## Integration Steps

### 1. Template Repository Setup

The Flutter template is located in the `backstage-template` repository:
```
https://github.com/Devweave/backstage-template.git
```

### 2. Backstage Repository Integration

The main Backstage instance is hosted at:
```
git@github.com:Devweave/backstage.git
```

### 3. Template Registration

To register the Flutter template in your Backstage instance, add the following to your `app-config.yaml` file in the `catalog.locations` section:

```yaml
catalog:
  locations:
    # Flutter template from backstage-template repository
    - type: url
      target: https://github.com/Devweave/backstage-template/blob/main/flutter-template/template.yaml
      rules:
        - allow: [Template]
```

Alternatively, if you have the backstage-template repository checked out locally alongside your Backstage instance:

```yaml
catalog:
  locations:
    # Flutter template from local backstage-template repository
    - type: file
      target: ../../../backstage-template/flutter-template/template.yaml
      rules:
        - allow: [Template]
```

### 4. Required Environment Setup

Ensure your Backstage environment has the following:

#### Flutter SDK
```bash
# Install Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
```

#### GitHub Integration
Ensure your `app-config.yaml` has GitHub integration configured:

```yaml
integrations:
  github:
    - host: github.com
      token: ${GITHUB_TOKEN}
```

Set the `GITHUB_TOKEN` environment variable with a Personal Access Token that has:
- `repo` scope for repository creation
- `write:packages` scope if using GitHub Packages
- Access to the Devweave organization

#### Required Backstage Plugins

Ensure the following plugins are installed in your Backstage instance:

1. **Scaffolder Plugin** (usually included by default)
2. **GitHub Integration Plugin** (usually included by default)
3. **Catalog Plugin** (usually included by default)

### 5. Verification

1. Start your Backstage instance:
   ```bash
   yarn dev
   ```

2. Navigate to "Create Component" in the sidebar
3. Look for "Flutter App Template" in the available templates
4. Test the template by creating a sample Flutter project

### 6. Template Customization

The template can be customized by modifying:

- `template.yaml`: Main template configuration
- `content/catalog-info.yaml`: Backstage catalog registration template
- `content/README.md`: Generated project documentation
- `content/.gitignore`: Git ignore rules for Flutter projects

### 7. Troubleshooting

#### Template Not Appearing
- Check Backstage logs for catalog processing errors
- Verify the template YAML syntax is valid
- Ensure the file path in `app-config.yaml` is correct

#### Flutter Commands Failing
- Verify Flutter SDK is installed and in PATH
- Check that `flutter pub global activate rename` works
- Ensure write permissions for global pub cache

#### GitHub Repository Creation Failing
- Verify GitHub token has correct permissions
- Check that the Devweave organization exists and token has access
- Ensure repository names don't conflict with existing repositories

### 8. Production Deployment

For production deployment:

1. Use the URL-based template registration pointing to the main branch
2. Set up proper environment variables for GitHub integration
3. Consider using external template storage for better reliability
4. Monitor template usage through Backstage analytics

## Template Features

The Flutter template provides:

- ✅ Cross-platform Flutter app scaffolding
- ✅ Customizable app name and package name
- ✅ Platform selection (Android, iOS, Web, Windows, Linux, macOS)
- ✅ Automatic GitHub repository creation
- ✅ Backstage catalog integration
- ✅ Comprehensive documentation generation
- ✅ Flutter-specific .gitignore rules
- ✅ Step-by-step logging for transparency

## Support

For issues with the template integration:

1. Check the Backstage documentation: https://backstage.io/docs/
2. Review the template repository: https://github.com/Devweave/backstage-template
3. Check the main Backstage instance: https://github.com/Devweave/backstage
4. Flutter boilerplate source: https://github.com/Devweave/flutter-boilerplate
