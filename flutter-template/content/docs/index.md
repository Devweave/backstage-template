# ${{ values.appName }}

Welcome to **${{ values.appName }}** documentation! This Flutter application is built using Clean Architecture principles with comprehensive testing and modern development practices.

## 🚀 Quick Links

- [Quick Start Guide](getting-started/quick-start.md) - Get up and running
- [Architecture Overview](architecture/overview.md) - Understand the project structure
- [Adding a Feature](guides/adding-feature.md) - Step-by-step development guide

## 📚 Documentation Sections

### Getting Started
Learn how to set up and configure the project.

- **[Quick Start](getting-started/quick-start.md)** - Bootstrap and run the project
- **[Installation](getting-started/installation.md)** - Detailed setup instructions
- **[Configuration](getting-started/configuration.md)** - API keys and environment setup

### Architecture
Deep dive into the Clean Architecture implementation.

- **[Overview](architecture/overview.md)** - High-level architecture concepts
- **[Clean Architecture](architecture/clean-architecture.md)** - Layer separation principles
- **[Project Structure](architecture/project-structure.md)** - Folder organization
- **[Data Flow](architecture/data-flow.md)** - How data moves through the app

### Features
Explore the built-in features and capabilities.

- **[Authentication](features/authentication.md)** - User authentication flow
- **[State Management](features/state-management.md)** - BLoC pattern implementation
- **[Routing](features/routing.md)** - Navigation with go_router
- **[Networking](features/networking.md)** - API integration with Dio
- **[Localization](features/localization.md)** - Multi-language support
- **[Storage](features/storage.md)** - Secure local data storage

### Development
Tools and practices for efficient development.

- **[Development Tools](development/tools.md)** - Makefile, FVM, and automation
- **[Testing](development/testing.md)** - Unit, widget, and integration tests
- **[Code Generation](development/code-generation.md)** - Freezed and build_runner
- **[Git Hooks](development/git-hooks.md)** - Automated quality checks

### Guides
Step-by-step tutorials for common tasks.

- **[Adding a Feature](guides/adding-feature.md)** - Create a new feature module
- **[Creating Use Cases](guides/creating-usecases.md)** - Implement business logic
- **[API Integration](guides/api-integration.md)** - Connect to external APIs
- **[Theming](guides/theming.md)** - Customize app appearance

### Reference
Quick reference materials and best practices.

- **[Dependencies](reference/dependencies.md)** - Package documentation
- **[Makefile Commands](reference/makefile.md)** - All available commands
- **[Best Practices](reference/best-practices.md)** - Coding standards

## 🎯 Key Features

- ✅ **Clean Architecture** - Separation of concerns
- ✅ **State Management** - BLoC pattern with flutter_bloc
- ✅ **Dependency Injection** - get_it with injectable
- ✅ **Code Generation** - Freezed for immutable classes
- ✅ **Routing** - go_router for declarative navigation
- ✅ **Testing** - Comprehensive test suite
- ✅ **Internationalization** - Multi-language support
- ✅ **Network Layer** - Dio for HTTP requests
- ✅ **Local Storage** - Secure storage
- ✅ **Development Tools** - Makefile automation, FVM, git hooks

## 📦 Project Information

- **Package Name**: `${{ values.packageName }}`
- **Platforms**: ${{ values.platforms | join(', ') }}
- **Repository**: [GitHub](https://github.com/Devweave/${{ values.repoName }})

## 🤝 Contributing

Contributions are welcome! Please follow the project conventions and coding standards.

## 📄 License

This project is licensed under the MIT License.
