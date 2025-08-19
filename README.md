# Backstage Templates Repository

This repository contains Backstage Software Templates for the Devweave organization.

## Available Templates

### Flutter App Template

**Location**: `flutter-template/`

A comprehensive Backstage template that scaffolds Flutter projects from the Devweave Flutter boilerplate with customizable configuration.

**Features:**
- Cross-platform Flutter app scaffolding (Android, iOS, Web, Windows, Linux, macOS)
- Customizable app name and package name
- Platform selection and configuration
- Automatic GitHub repository creation
- Backstage catalog integration
- Comprehensive project documentation

**Quick Start:**
1. Ensure this template is registered in your Backstage catalog
2. Navigate to "Create Component" in Backstage
3. Select "Flutter App Template"
4. Fill in the configuration parameters
5. Click "Create" to scaffold your Flutter project

## Repository Structure

```
backstage-template/
├── flutter-template/           # Flutter app template
│   ├── template.yaml          # Main template configuration
│   ├── docs.md               # Template documentation
│   └── content/              # Template files
│       ├── catalog-info.yaml # Backstage catalog template
│       ├── README.md         # Project README template
│       └── .gitignore        # Flutter .gitignore template
├── INTEGRATION.md            # Integration guide
└── README.md                # This file
```

## Integration with Backstage

### URL-based Registration (Recommended for Production)

Add to your Backstage `app-config.yaml`:

```yaml
catalog:
  locations:
    - type: url
      target: https://github.com/Devweave/backstage-template/blob/main/flutter-template/template.yaml
      rules:
        - allow: [Template]
```

### Local File Registration (Development)

If you have this repository checked out locally:

```yaml
catalog:
  locations:
    - type: file
      target: ../../../backstage-template/flutter-template/template.yaml
      rules:
        - allow: [Template]
```

## Requirements

### Environment Setup
- Flutter SDK installed and configured
- GitHub Personal Access Token with repository creation permissions
- Access to Devweave GitHub organization

### Backstage Plugins
- Scaffolder Plugin (default)
- GitHub Integration Plugin (default)
- Catalog Plugin (default)

## Template Development

### Adding New Templates

1. Create a new directory for your template
2. Add a `template.yaml` file with the template configuration
3. Create a `content/` directory with template files
4. Add documentation in a `docs.md` file
5. Register the template in Backstage

### Template Structure

Each template should follow this structure:
```
template-name/
├── template.yaml          # Template configuration
├── docs.md               # Template documentation
└── content/              # Template files
    ├── catalog-info.yaml # Backstage registration
    └── ...               # Other template files
```

### Testing Templates

1. Register the template in a development Backstage instance
2. Test the template creation process
3. Verify generated projects work correctly
4. Check Backstage catalog registration

## Contributing

1. Fork this repository
2. Create a feature branch for your template
3. Add your template following the established structure
4. Test the template thoroughly
5. Submit a pull request with a detailed description

### Contribution Guidelines

- Follow existing naming conventions
- Include comprehensive documentation
- Test templates in a development environment
- Ensure templates generate working projects
- Include appropriate error handling and logging

## Support

For issues with templates in this repository:

1. Check the integration guide: [INTEGRATION.md](./INTEGRATION.md)
2. Review individual template documentation
3. Check the Backstage documentation: https://backstage.io/docs/
4. Open an issue in this repository

## Related Repositories

- **Backstage Instance**: https://github.com/Devweave/backstage
- **Flutter Boilerplate**: https://github.com/Devweave/flutter-boilerplate

## License

This project is licensed under the MIT License - see the LICENSE file for details.
