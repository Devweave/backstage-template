# Flutter Feature Template Examples

This file shows example configurations for different types of features you can generate.

## Complete CRUD Feature Example

**Feature Configuration:**
- feature_name: `user_management`
- type_feature: `new`

**Domain Layer:**
- add_entity: `true`
- entity_name: `user`
- add_repository: `true`
- repository_name: `user_repository`
- add_usecase: `true`
- usecase_name: `get_users`

**Data Layer:**
- add_model: `true`
- model_name: `user_model`
- add_datasource: `true`
- datasource_name: `user_remote_datasource`
- add_repository_impl: `true`

**Presentation Layer:**
- add_screen: `true`
- screen_name: `user_list_screen`
- add_bloc: `true`
- bloc_name: `user`

**Generated Files:**
```
lib/features/user_management/
├── domain/
│   ├── entities/user.dart
│   ├── repositories/user_repository.dart
│   └── usecases/get_users.dart
├── data/
│   ├── models/user_model.dart
│   ├── datasources/user_remote_datasource.dart
│   └── repositories/user_repository_impl.dart
└── presentation/
    ├── pages/user_list_screen.dart
    ├── bloc/
    │   ├── user_bloc.dart
    │   ├── user_event.dart
    │   └── user_state.dart
    └── widgets/
        ├── user_management_list_widget.dart
        └── user_management_search_widget.dart
```

## API Integration Only Example

**Feature Configuration:**
- feature_name: `api_integration`
- type_feature: `new`

**Domain Layer:**
- add_entity: `false`
- add_repository: `true`
- repository_name: `api_repository`
- add_usecase: `true`
- usecase_name: `fetch_data`

**Data Layer:**
- add_model: `false`
- add_datasource: `true`
- datasource_name: `api_remote_datasource`
- add_repository_impl: `true`

**Presentation Layer:**
- add_screen: `false`
- add_bloc: `false`

## UI Only Feature Example

**Feature Configuration:**
- feature_name: `dashboard`
- type_feature: `new`

**Domain Layer:**
- add_entity: `false`
- add_repository: `false`
- add_usecase: `false`

**Data Layer:**
- add_model: `false`
- add_datasource: `false`
- add_repository_impl: `false`

**Presentation Layer:**
- add_screen: `true`
- screen_name: `dashboard_screen`
- add_bloc: `true`
- bloc_name: `dashboard`

## Minimal Business Logic Example

**Feature Configuration:**
- feature_name: `notification`
- type_feature: `new`

**Domain Layer:**
- add_entity: `true`
- entity_name: `notification`
- add_repository: `false`
- add_usecase: `true`
- usecase_name: `process_notification`

**Data Layer:**
- add_model: `true`
- model_name: `notification_model`
- add_datasource: `false`
- add_repository_impl: `false`

**Presentation Layer:**
- add_screen: `false`
- add_bloc: `false`