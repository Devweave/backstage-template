# User: ${{ values.displayName }}

This catalog entry was created for user **${{ values.displayName }}** (${{ values.username }}).

## User Information

- **Username**: ${{ values.username }}
- **Display Name**: ${{ values.displayName }}
- **Email**: ${{ values.email }}
{% if values.title %}- **Job Title**: ${{ values.title }}{% endif %}
- **Group Membership**: ${{ values.memberOf }}

{% if values.description %}
## Description

${{ values.description }}
{% endif %}

## Usage

This user catalog entry was automatically generated using the Backstage User Catalog Template. The user is now registered in the Backstage catalog and can be referenced in other catalog entities.

## Next Steps

1. The user should be able to log into Backstage using their configured authentication method
2. They will have permissions based on their group membership: `${{ values.memberOf }}`
3. The user can now be assigned as an owner of components, systems, or other catalog entities

For any updates to this user's information, please update the `catalog-info.yaml` file in this repository.
