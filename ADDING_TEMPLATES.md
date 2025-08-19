# Adding New Templates Guide

This guide explains how to add new Backstage templates to the Devweave template repository with automatic discovery.

## 🚀 The New Approach: Automatic Template Discovery

With the new system, you **don't need to manually update** the main Backstage configuration when adding templates. The system automatically discovers and registers all templates using a **Makefile-based approach**.

### How It Works

1. **Template Discovery**: The `Makefile` automatically finds all `template.yaml` files
2. **Catalog Generation**: Creates a `catalog-info.yaml` that lists all discovered templates
3. **Automatic Updates**: GitHub Actions regenerate the catalog when templates are added/modified
4. **Dynamic Registration**: Main Backstage fetches templates from the centralized catalog

### Available Commands

```bash
make help                # Show all available commands
make discover-templates  # Find all template.yaml files
make generate-catalog   # Create catalog-info.yaml
make validate-templates # Check template YAML syntax
make status            # Show current template status
make all              # Run full pipeline (validate + generate + status)
make init             # Initialize new template repository
```

## 📁 Template Structure

Each template should follow this structure:

```
template-name/
├── template.yaml              # Backstage template configuration
├── docs.md                   # Template documentation (optional)
└── content/                  # Template files (optional)
    ├── catalog-info.yaml     # Generated project catalog registration
    ├── README.md            # Generated project documentation
    └── ...                  # Other template files
```

## ➕ Adding a New Template

### Step 1: Create Template Directory

```bash
cd backstage-template/
mkdir my-new-template
cd my-new-template
```

### Step 2: Create template.yaml

```yaml
apiVersion: scaffolder.backstage.io/v1beta3
kind: Template
metadata:
  name: my-template
  title: My Awesome Template
  description: Description of what this template does
  tags:
    - recommended
    - react
spec:
  owner: user:guest
  type: service
  
  parameters:
    - title: Basic Information
      required:
        - name
      properties:
        name:
          title: Name
          type: string
          description: Unique name of the component
  
  steps:
    - id: fetch
      name: Fetch Base
      action: fetch:template
      input:
        url: ./content
        values:
          name: ${{ parameters.name }}
    
    - id: publish
      name: Publish
      action: publish:github
      input:
        description: This is ${{ parameters.name }}
        repoUrl: ${{ parameters.repoUrl }}
  
  output:
    links:
      - title: Repository
        url: ${{ steps['publish'].output.remoteUrl }}
```

### Step 3: Create Content Directory (if needed)

```bash
mkdir content
# Add your template files here
```

### Step 4: Test Template Locally

```bash
# From the backstage-template root directory
make validate-templates   # Check YAML syntax
make generate-catalog     # Update catalog-info.yaml
make status              # Show template status
```

This will:
- ✅ Validate your template YAML syntax
- ✅ Discover your new template
- ✅ Update `catalog-info.yaml`
- ✅ Show you the template registration status

### Step 5: Commit and Push

```bash
git add .
git commit -m "Add my-new-template"
git push
```

The GitHub Action will automatically:
- ✅ Regenerate the catalog
- ✅ Update the catalog-info.yaml if needed
- ✅ Make the template available in Backstage

## 🔄 Automatic Discovery Process

### What Happens Automatically

1. **On Push/PR**: GitHub Action triggers
2. **Template Validation**: `make validate-templates` checks YAML syntax
3. **Template Scan**: `make discover-templates` finds all `**/template.yaml` files
4. **Catalog Update**: `make generate-catalog` generates new `catalog-info.yaml`
5. **Auto-Commit**: Commits updated catalog if changes detected
6. **Backstage Sync**: Backstage automatically discovers new templates

### Main Backstage Configuration

The main Backstage only needs this **one-time configuration**:

```yaml
# app-config.yaml
catalog:
  locations:
    - type: url
      target: https://github.com/Devweave/backstage-template/blob/main/catalog-info.yaml
      rules:
        - allow: [Location, Template]
```

## 📋 Template Best Practices

### Template Metadata

```yaml
metadata:
  name: descriptive-name          # Kebab-case, unique
  title: Human Readable Title     # User-friendly name
  description: Clear description  # What the template does
  tags:                          # Searchable tags
    - framework-name
    - language
    - platform
```

### Input Parameters

```yaml
parameters:
  - title: Configuration
    required:
      - name
      - description
    properties:
      name:
        title: Component Name
        type: string
        pattern: '^[a-z][a-z0-9-]*$'
        ui:help: 'Lowercase letters, numbers, and hyphens only'
```

### Template Steps

```yaml
steps:
  - id: fetch-base
    name: Fetch Base Template
    action: fetch:template
    input:
      url: ./content
      values:
        name: ${{ parameters.name }}
        
  - id: publish
    name: Publish to GitHub
    action: publish:github
    input:
      description: ${{ parameters.description }}
      repoUrl: ${{ parameters.repoUrl }}
```

## 🧪 Testing Templates

### Local Testing

1. **Validate YAML**:
   ```bash
   make validate-templates
   ```

2. **Test Discovery**:
   ```bash
   make discover-templates
   ```

3. **Generate Catalog**:
   ```bash
   make generate-catalog
   ```

4. **Full Pipeline**:
   ```bash
   make all
   ```

5. **Check Backstage**:
   - Restart Backstage development server
   - Navigate to "Create Component"
   - Verify template appears

### Template Validation

Ensure your template:
- ✅ Has valid YAML syntax
- ✅ Includes required metadata fields
- ✅ Has proper step definitions
- ✅ Generates working projects
- ✅ Includes appropriate documentation

## 🔧 Troubleshooting

### Template Not Appearing

1. **Check Discovery**: Run `make discover-templates` locally
2. **Validate YAML**: Run `make validate-templates` to check syntax
3. **Check Backstage Logs**: Look for catalog processing errors
4. **Verify Catalog**: Check if catalog-info.yaml was updated with `make status`

### GitHub Action Failures

1. **Check Workflow**: View GitHub Actions tab for errors
2. **Permissions**: Ensure GITHUB_TOKEN has write permissions
3. **Makefile**: Verify Makefile commands work locally with `make all`

### Backstage Template Errors

1. **Step Actions**: Ensure all actions are available in your Backstage instance
2. **Parameter Validation**: Check parameter patterns and requirements
3. **Output References**: Verify step output references are correct

## 📚 Examples

### Current Templates

- **Flutter Template**: `flutter-template/` - Cross-platform Flutter app scaffolding

### Template Ideas

- **React App Template**: Modern React application with TypeScript
- **Node.js API Template**: Express.js REST API with documentation
- **Python Package Template**: Python package with testing and CI/CD
- **Documentation Template**: MkDocs or Docusaurus documentation site

## 🎯 Benefits of This Approach

### For Template Creators
- ✅ **No Manual Registration**: Templates are automatically discovered
- ✅ **Simple Addition**: Just add template.yaml and push
- ✅ **Immediate Availability**: Templates appear in Backstage automatically
- ✅ **Version Control**: All templates versioned together

### For Backstage Maintainers
- ✅ **Zero Configuration**: No need to update main Backstage config
- ✅ **Centralized Management**: All templates in one repository
- ✅ **Automatic Updates**: Templates sync automatically
- ✅ **Scalable**: Easy to add unlimited templates

### For Template Users
- ✅ **Always Up-to-Date**: Latest templates available immediately
- ✅ **Consistent Experience**: All templates follow same patterns
- ✅ **Rich Discovery**: Templates include metadata and documentation
