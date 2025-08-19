# Backstage Templates Repository

This repository contains Backstage Software Templates for the Devweave organization with **automatic template discovery**.

## 🚀 Automatic Template Discovery

This repository uses an innovative **Makefile-based approach** where templates are **automatically discovered and registered** without manual configuration in the main Backstage instance.

### How It Works

1. **Add Template**: Simply add a new `template.yaml` file anywhere in the repository
2. **Auto-Discovery**: Makefile commands automatically detect and catalog the template
3. **GitHub Actions**: Automatically run `make generate-catalog` on template changes
4. **Dynamic Registration**: Backstage automatically loads all templates from the centralized catalog
5. **Zero Maintenance**: No need to manually update the main Backstage configuration

### Quick Commands

```bash
make help                # Show all available commands
make discover-templates  # Find all templates
make generate-catalog   # Update catalog-info.yaml
make validate-templates # Check template syntax
make all               # Run full pipeline
```

## 📁 Available Templates

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
1. Navigate to "Create Component" in Backstage
2. Select "Flutter App Template"
3. Fill in the configuration parameters
4. Click "Create" to scaffold your Flutter project

## ➕ Adding New Templates

Adding a new template is incredibly simple:

```bash
# 1. Create template directory
mkdir my-awesome-template

# 2. Add template.yaml
# (see ADDING_TEMPLATES.md for details)

# 3. Test locally
make validate-templates
make generate-catalog

# 4. Commit and push
git add .
git commit -m "Add my-awesome-template"
git push
```

**That's it!** The template will be automatically:
- ✅ Validated for YAML syntax errors
- ✅ Discovered by the auto-discovery system
- ✅ Added to the template catalog
- ✅ Available in Backstage within minutes

📖 **Detailed Guide**: See [ADDING_TEMPLATES.md](./ADDING_TEMPLATES.md) for complete instructions.

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

## 🔧 Integration with Backstage

### One-Time Setup (Recommended)

Add this **single line** to your Backstage `app-config.yaml`:

```yaml
catalog:
  locations:
    - type: url
      target: https://github.com/Devweave/backstage-template/blob/main/catalog-info.yaml
      rules:
        - allow: [Location, Template]
```

This will automatically discover **all current and future templates** in this repository.

### Alternative: Local Development

For local development with this repository checked out:

```yaml
catalog:
  locations:
    - type: file
      target: ../../../backstage-template/catalog-info.yaml
      rules:
        - allow: [Location, Template]
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
