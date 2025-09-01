# User Catalog Template Documentation

This template creates a new user entry in the Backstage catalog when a user doesn't exist in the current catalog.

## Overview

The User Catalog Template helps you quickly create standardized user catalog entries with the following features:

- **User Information**: Username, display name, and email
- **Group Membership**: Default assignment to `group:default/guests` with options for other groups
- **Optional Fields**: Job title and description
- **Automatic Registration**: Creates a new repository and registers the user in the catalog

## Template Parameters

### Required Fields

1. **Username**: Unique identifier (lowercase, no spaces)
2. **Display Name**: Full name of the user
3. **Email**: Valid email address
4. **Repository Location**: Where to store the user catalog file

### Optional Fields

1. **Group Membership**: Choose from guests, admins, or developers (defaults to guests)
2. **Job Title**: User's role or position
3. **Description**: Brief description about the user

## Usage

1. Navigate to the Backstage Software Catalog
2. Click "Create Component"
3. Select "User Catalog Template"
4. Fill in the required information
5. Choose the repository location
6. Review and create

## Output

The template creates:

- A new repository with the user catalog file
- `catalog-info.yaml` with the user definition
- `README.md` with user information and usage instructions
- Automatic registration in the Backstage catalog

## Group Memberships

- **group:default/guests**: Standard user permissions (default)
- **group:default/admins**: Administrative permissions
- **group:default/developers**: Developer-specific permissions

## Example Output

```yaml
apiVersion: backstage.io/v1alpha1
kind: User
metadata:
  name: john.doe
spec:
  profile:
    displayName: John Doe
    email: john.doe@company.com
  memberOf: [group:default/guests]
```

## Best Practices

1. Use meaningful usernames that match your organization's naming conventions
2. Ensure email addresses are valid and accessible
3. Assign appropriate group memberships based on user roles
4. Include job titles and descriptions when available for better searchability
