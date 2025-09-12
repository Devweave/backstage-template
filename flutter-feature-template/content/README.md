# Flutter Feature Template Content

This directory contains the template files that will be generated when using the Flutter Feature Template in Backstage.

## Structure

```
content/
├── lib/features/${{ values.feature_name }}/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── ${{ values.entity_name }}.dart
│   │   ├── repositories/
│   │   │   └── ${{ values.repository_name }}.dart
│   │   └── usecases/
│   │       └── ${{ values.usecase_name }}.dart
│   ├── data/
│   │   ├── models/
│   │   │   └── ${{ values.model_name }}.dart
│   │   ├── datasources/
│   │   │   └── ${{ values.datasource_name }}.dart
│   │   └── repositories/
│   │       └── ${{ values.repository_name }}_impl.dart
│   └── presentation/
│       ├── pages/
│       │   └── ${{ values.screen_name }}.dart
│       ├── bloc/
│       │   ├── ${{ values.bloc_name }}_bloc.dart
│       │   ├── ${{ values.bloc_name }}_event.dart
│       │   └── ${{ values.bloc_name }}_state.dart
│       └── widgets/
│           ├── ${{ values.feature_name }}_list_widget.dart
│           └── ${{ values.feature_name }}_search_widget.dart
└── test/features/${{ values.feature_name }}/
    ├── domain/
    │   └── ${{ values.entity_name }}_test.dart
    └── presentation/
        └── ${{ values.bloc_name }}_bloc_test.dart
```

## Template Variables

All files use Backstage templating syntax with the following variables:

### Feature Configuration
- `${{ values.feature_name }}` - Name of the feature
- `${{ values.type_feature }}` - Type of feature (new/existing)

### Domain Layer
- `${{ values.add_entity }}` - Boolean to include entity
- `${{ values.entity_name }}` - Name of the entity
- `${{ values.add_repository }}` - Boolean to include repository
- `${{ values.repository_name }}` - Name of the repository
- `${{ values.add_usecase }}` - Boolean to include use case
- `${{ values.usecase_name }}` - Name of the use case

### Data Layer
- `${{ values.add_model }}` - Boolean to include model
- `${{ values.model_name }}` - Name of the model
- `${{ values.add_datasource }}` - Boolean to include data source
- `${{ values.datasource_name }}` - Name of the data source
- `${{ values.add_repository_impl }}` - Boolean to include repository implementation

### Presentation Layer
- `${{ values.add_screen }}` - Boolean to include screen
- `${{ values.screen_name }}` - Name of the screen
- `${{ values.add_bloc }}` - Boolean to include BLoC
- `${{ values.bloc_name }}` - Name of the BLoC

## Conditional Generation

Files are only generated when their corresponding boolean flag is true. This allows for flexible feature generation based on actual needs.

## Architecture Patterns

### Clean Architecture
- **Domain Layer**: Core business logic, entities, and use cases
- **Data Layer**: Data access, models, and repository implementations
- **Presentation Layer**: UI components, state management with BLoC

### State Management
- Uses BLoC pattern for state management
- Includes events, states, and bloc implementation
- Follows reactive programming principles

### Error Handling
- Result pattern for handling success/error states
- Custom failure types for different error scenarios
- Comprehensive error handling in repository implementations

### Testing
- Unit tests for entities and business logic
- BLoC tests with bloc_test package
- Mock implementations for dependencies
- Test coverage for all generated components

## Dependencies

The generated code assumes the following dependencies are available:

### Core
- `flutter_bloc` - State management
- `freezed` - Code generation for data classes
- `json_annotation` - JSON serialization
- `injectable` - Dependency injection

### Networking
- `dio` - HTTP client

### Testing
- `flutter_test` - Testing framework
- `bloc_test` - BLoC testing utilities
- `mockito` - Mocking framework

## Usage Notes

1. Run code generation after creating files:
   ```bash
   flutter packages pub run build_runner build
   ```

2. Update dependency injection configuration to include new services

3. Add routing configuration for new screens

4. Update the main app module to include the new feature

5. Run tests to ensure everything is working correctly:
   ```bash
   flutter test
   ```