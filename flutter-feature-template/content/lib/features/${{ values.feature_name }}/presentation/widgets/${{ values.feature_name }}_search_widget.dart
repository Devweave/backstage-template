{% if values.add_bloc %}
import 'package:flutter/material.dart';

class ${{ values.feature_name | pascalcase }}SearchWidget extends StatefulWidget {
  final String query;
  final Function(String) onQueryChanged;
  final VoidCallback onClearSearch;

  const ${{ values.feature_name | pascalcase }}SearchWidget({
    super.key,
    required this.query,
    required this.onQueryChanged,
    required this.onClearSearch,
  });

  @override
  State<${{ values.feature_name | pascalcase }}SearchWidget> createState() => _${{ values.feature_name | pascalcase }}SearchWidgetState();
}

class _${{ values.feature_name | pascalcase }}SearchWidgetState extends State<${{ values.feature_name | pascalcase }}SearchWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant ${{ values.feature_name | pascalcase }}SearchWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search {% if values.add_entity %}${{ values.entity_name | lower }}s{% else %}items{% endif %}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: widget.onQueryChanged,
              onSubmitted: widget.onQueryChanged,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              _controller.clear();
              widget.onClearSearch();
            },
            icon: const Icon(Icons.clear),
            tooltip: 'Clear search',
          ),
        ],
      ),
    );
  }
}

class ${{ values.feature_name | pascalcase }}FilterWidget extends StatelessWidget {
  final bool showActiveOnly;
  final Function(bool) onActiveFilterChanged;
  final String? selectedCategory;
  final List<String> categories;
  final Function(String?) onCategoryChanged;

  const ${{ values.feature_name | pascalcase }}FilterWidget({
    super.key,
    required this.showActiveOnly,
    required this.onActiveFilterChanged,
    this.selectedCategory,
    this.categories = const [],
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          
          // Active filter
          CheckboxListTile(
            title: const Text('Show active only'),
            value: showActiveOnly,
            onChanged: (value) => onActiveFilterChanged(value ?? false),
            contentPadding: EdgeInsets.zero,
          ),
          
          // Category filter
          if (categories.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Category',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              hint: const Text('All categories'),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('All categories'),
                ),
                ...categories.map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                )),
              ],
              onChanged: onCategoryChanged,
            ),
          ],
        ],
      ),
    );
  }
}
{% endif %}