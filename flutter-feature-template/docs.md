# Flutter Feature Template

## Overview

This Backstage template generates Flutter features following Clean Architecture principles. It creates a complete feature structure with conditional components based on your specific needs.

## Architecture

The template follows Clean Architecture with three main layers:

```
lib/features/{feature_name}/
├── domain/              # Business logic layer
│   ├── entities/        # Core business objects
│   ├── repositories/    # Abstract interfaces
│   └── usecases/        # Business use cases
├── data/                # Data access layer
│   ├── models/          # Data transfer objects
│   ├── datasources/     # Data source implementations
│   └── repositories/    # Repository implementations
└── presentation/        # UI layer
    ├── pages/           # Screen/page widgets
    ├── bloc/            # State management
    └── widgets/         # Reusable UI components
```

## Parameters

### Feature Configuration

- **feature_name** (required): Name of the feature in snake_case (e.g., "user_profile", "notifications")
- **type_feature** (required): Whether to create a new feature or add to existing
  - `new`: Creates a new feature directory
  - `existing`: Adds components to existing feature

### Presentation Layer Components

- **add_screen**: Generate a Flutter screen/page
  - If true, requires **screen_name**: Name of the screen (e.g., "profile_screen")
- **add_bloc**: Generate BLoC state management components
  - If true, requires **bloc_name**: Name of the BLoC (e.g., "profile")

### Domain Layer Components

- **add_entity**: Generate domain entity class
  - If true, requires **entity_name**: Name of the entity (e.g., "user")
- **add_usecase**: Generate use case implementation
  - If true, requires **usecase_name**: Name of the use case (e.g., "get_user_profile")
- **add_repository**: Generate repository interface
  - If true, requires **repository_name**: Name of the repository (e.g., "user_repository")

### Data Layer Components

- **add_model**: Generate data model class
  - If true, requires **model_name**: Name of the model (e.g., "user_model")
- **add_datasource**: Generate data source implementation
  - If true, requires **datasource_name**: Name of the data source (e.g., "user_remote_datasource")
- **add_repository_impl**: Generate repository implementation

### Repository Configuration

- **repo_url** (required): Target repository URL where the feature will be created

## Generated Files

### Domain Layer (`lib/features/{feature_name}/domain/`)

- **entities/{entity_name}.dart**: Core business entity with Freezed annotations
- **repositories/{repository_name}.dart**: Abstract repository interface
- **usecases/{usecase_name}.dart**: Business use case implementation

### Data Layer (`lib/features/{feature_name}/data/`)

- **models/{model_name}.dart**: Data model with JSON serialization and entity conversion
- **datasources/{datasource_name}.dart**: Data source interface and implementation
- **repositories/{repository_name}_impl.dart**: Repository implementation with error handling

### Presentation Layer (`lib/features/{feature_name}/presentation/`)

- **pages/{screen_name}.dart**: Flutter screen with BLoC integration
- **bloc/{bloc_name}_bloc.dart**: BLoC implementation
- **bloc/{bloc_name}_event.dart**: BLoC events
- **bloc/{bloc_name}_state.dart**: BLoC states

### Test Files (`test/features/{feature_name}/`)

All generated files include corresponding test files with the same structure and `_test.dart` suffix.

## Dependencies

The template assumes your Flutter project includes:

- `flutter_bloc`: State management
- `freezed`: Code generation for data classes
- `json_annotation`: JSON serialization
- `injectable`: Dependency injection
- `dio`: HTTP client

## Example Usage

### Simple CRUD Feature

To create a complete user management feature:

1. **Feature Configuration**:
   - feature_name: `user_management`
   - type_feature: `new`

2. **Components** (all selected):
   - add_entity: true, entity_name: `user`
   - add_repository: true, repository_name: `user_repository`
   - add_usecase: true, usecase_name: `get_users`
   - add_model: true, model_name: `user_model`
   - add_datasource: true, datasource_name: `user_remote_datasource`
   - add_repository_impl: true
   - add_bloc: true, bloc_name: `user`
   - add_screen: true, screen_name: `user_list_screen`

This generates a complete feature with:
- User entity and model
- Repository pattern implementation
- BLoC state management
- List screen with CRUD operations
- Complete test coverage

### API-Only Feature

For backend integration without UI:

1. Select only data and domain components
2. Skip presentation layer components
3. Focus on repository, use cases, and data sources

### UI-Only Feature

For UI components without business logic:

1. Select only presentation components
2. Add screen and BLoC
3. Skip domain and data layers if using existing services

## File Templates

All generated files follow established patterns:

- **Entities**: Immutable classes with Freezed
- **Models**: JSON serializable with entity conversion
- **Repositories**: Abstract interfaces with Result pattern
- **Use Cases**: Single responsibility with dependency injection
- **BLoC**: Event-driven state management
- **Screens**: Stateless widgets with BLoC providers

## Error Handling

The template includes comprehensive error handling:

- Result pattern for repository operations
- DioException handling in data sources
- Failure types (NetworkFailure, ServerFailure)
- Error states in BLoC

## Testing

Generated test files include:

- Unit tests for all business logic
- Widget tests for UI components
- Mock implementations for external dependencies
- Test utilities and helpers

## Best Practices

The template enforces:

- Clean Architecture separation of concerns
- Dependency inversion principle
- Single responsibility principle
- Immutable data structures
- Proper error handling
- Comprehensive testing
- Consistent naming conventions

## Customization

You can customize the template by:

1. Modifying file templates in the `content/` directory
2. Adjusting the parameter schema in `template.yaml`
3. Adding new conditional components
4. Extending the test coverage

## Troubleshooting

### Common Issues

1. **Missing Dependencies**: Ensure all required packages are in your `pubspec.yaml`
2. **Import Errors**: Run `flutter packages get` after generation
3. **Code Generation**: Run `flutter packages pub run build_runner build`
4. **Naming Conflicts**: Use unique names for entities and components

### Support

For issues or questions:
1. Check the generated PR description for component overview
2. Verify all selected components were generated
3. Run Flutter analyze to check for issues
4. Contact the Flutter team for template improvements