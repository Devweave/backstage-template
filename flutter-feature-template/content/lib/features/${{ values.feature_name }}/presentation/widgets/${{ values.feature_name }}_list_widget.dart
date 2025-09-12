{% if values.add_screen or values.add_bloc %}
import 'package:flutter/material.dart';
{% if values.add_entity %}
import '../../domain/entities/${{ values.entity_name }}.dart';
{% endif %}

class ${{ values.feature_name | pascalcase }}ListWidget extends StatelessWidget {
  final {% if values.add_entity %}List<${{ values.entity_name | pascalcase }}>{% else %}List<Map<String, dynamic>>{% endif %} {% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %};
  final {% if values.add_entity %}Function(${{ values.entity_name | pascalcase }}){% else %}Function(Map<String, dynamic>){% endif %}? onItemTap;
  final {% if values.add_entity %}Function(${{ values.entity_name | pascalcase }}){% else %}Function(Map<String, dynamic>){% endif %}? onItemEdit;
  final {% if values.add_entity %}Function(${{ values.entity_name | pascalcase }}){% else %}Function(Map<String, dynamic>){% endif %}? onItemDelete;
  final ScrollController? scrollController;
  final bool isLoading;

  const ${{ values.feature_name | pascalcase }}ListWidget({
    super.key,
    required this.{% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %},
    this.onItemTap,
    this.onItemEdit,
    this.onItemDelete,
    this.scrollController,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if ({% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %}.isEmpty && !isLoading) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: {% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %}.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= {% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %}.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = {% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %}[index];
        return ${{ values.feature_name | pascalcase }}ListItem(
          {% if values.add_entity %}${{ values.entity_name }}{% else %}item{% endif %}: item,
          onTap: () => onItemTap?.call(item),
          onEdit: () => onItemEdit?.call(item),
          onDelete: () => onItemDelete?.call(item),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'No {% if values.add_entity %}${{ values.entity_name | title }}s{% else %}Items{% endif %} Found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add some {% if values.add_entity %}${{ values.entity_name | lower }}s{% else %}items{% endif %} to get started',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ${{ values.feature_name | pascalcase }}ListItem extends StatelessWidget {
  final {% if values.add_entity %}${{ values.entity_name | pascalcase }}{% else %}Map<String, dynamic>{% endif %} {% if values.add_entity %}${{ values.entity_name }}{% else %}item{% endif %};
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ${{ values.feature_name | pascalcase }}ListItem({
    super.key,
    required this.{% if values.add_entity %}${{ values.entity_name }}{% else %}item{% endif %},
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    {% if values.add_entity %}
    final name = ${{ values.entity_name }}.name;
    final description = ${{ values.entity_name }}.description;
    final isActive = ${{ values.entity_name }}.isActive;
    final createdAt = ${{ values.entity_name }}.createdAt;
    {% else %}
    final name = item['name']?.toString() ?? 'Unnamed Item';
    final description = item['description']?.toString();
    final isActive = item['isActive'] as bool? ?? false;
    final createdAt = item['createdAt'] != null 
        ? DateTime.tryParse(item['createdAt'].toString())
        : null;
    {% endif %}

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: isActive ? Colors.green : Colors.grey,
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : '?',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: isActive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive ? 'Active' : 'Inactive',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isActive ? Colors.green : Colors.red,
                  ),
                ),
                if (createdAt != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
{% endif %}