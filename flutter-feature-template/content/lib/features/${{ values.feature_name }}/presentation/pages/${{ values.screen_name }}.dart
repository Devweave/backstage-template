import 'package:flutter/material.dart';
{% if values.add_bloc %}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/${{ values.bloc_name }}_bloc.dart';
{% endif %}
{% if values.add_entity %}
import '../../domain/entities/${{ values.entity_name }}.dart';
{% endif %}

class ${{ values.screen_name | pascalcase }}Page extends StatelessWidget {
  const ${{ values.screen_name | pascalcase }}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return {% if values.add_bloc %}BlocProvider(
      create: (context) => get_it<${{ values.bloc_name | pascalcase }}Bloc>()
        ..add(const ${{ values.bloc_name | pascalcase }}Event.get${{ values.feature_name | pascalcase }}()),
      child: const ${{ values.screen_name | pascalcase }}View(),
    ){% else %}const ${{ values.screen_name | pascalcase }}View(){% endif %};
  }
}

class ${{ values.screen_name | pascalcase }}View extends StatelessWidget {
  const ${{ values.screen_name | pascalcase }}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${{ values.feature_name | title }}'),
        actions: [
{% if values.add_bloc %}
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<${{ values.bloc_name | pascalcase }}Bloc>()
                .add(const ${{ values.bloc_name | pascalcase }}Event.get${{ values.feature_name | pascalcase }}()),
          ),
{% endif %}
        ],
      ),
      body: {% if values.add_bloc %}BlocBuilder<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.errorMessage}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<${{ values.bloc_name | pascalcase }}Bloc>()
                        .add(const ${{ values.bloc_name | pascalcase }}Event.get${{ values.feature_name | pascalcase }}()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          {% if values.add_entity %}
          if (state.${{ values.entity_name }}s.isEmpty) {
            return const Center(
              child: Text('No ${{ values.entity_name | title }}s found'),
            );
          }

          return ListView.builder(
            itemCount: state.${{ values.entity_name }}s.length,
            itemBuilder: (context, index) {
              final ${{ values.entity_name | lower }} = state.${{ values.entity_name }}s[index];
              return ListTile(
                title: Text(${{ values.entity_name | lower }}.name),
                subtitle: Text(${{ values.entity_name | lower }}.description),
                onTap: () {
                  // Navigate to detail screen
                  print('Tapped on ${${{ values.entity_name | lower }}.name}');
                },
              );
            },
          );
          {% else %}
          if (state.items.isEmpty) {
            return const Center(
              child: Text('No items found'),
            );
          }

          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return ListTile(
                title: Text(item['name'] ?? 'Unnamed'),
                subtitle: Text(item['description'] ?? 'No description'),
                onTap: () {
                  // Navigate to detail screen
                  print('Tapped on ${item['name']}');
                },
              );
            },
          );
          {% endif %}
        },
      ){% else %}const Center(
        child: Text('${{ values.feature_name | title }} Screen - No BLoC'),
      ){% endif %},
    );
  }
}