# Quick Start

Get your Flutter app up and running quickly!

## Prerequisites

- **Flutter SDK**: 3.32.4 (managed with FVM)
- **Dart SDK**: >=3.3.3 <4.0.0
- **FVM**: [Install FVM](https://fvm.app/docs/getting_started/installation)
- **Make**: For build automation (optional but recommended)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Devweave/${{ values.repoName }}.git
cd ${{ values.repoName }}
```

### 2. Setup Flutter Version

```bash
fvm install 3.32.4
fvm use 3.32.4
```

### 3. Bootstrap the Project ⚠️ **REQUIRED**

```bash
make bootstrap
```

!!! warning "Critical Step"
    This command installs dependencies, generates code, and sets up git hooks. **DO NOT SKIP!**

### 4. Configure API Keys

```bash
cp api-keys.example.json api-keys.json
# Edit api-keys.json with your API keys
```

### 5. Run the App

```bash
make run
```

## What's Next?

- 📖 Learn about the [Architecture](../architecture/overview.md)
- ✨ [Add a New Feature](../guides/adding-feature.md)
- 🧪 Explore [Testing](../development/testing.md)

## Common Issues

### Git Hooks Not Working

```bash
make setup-git-hooks
```

### Build Runner Errors

```bash
make clean
make gen
```
