{%- if values.add_datasource %}
import 'package:injectable/injectable.dart';
{%- if values.add_model %}
import '../models/${{ values.model_name }}.dart';
{%- endif %}

abstract class ${{ values.datasource_name | pascalcase }} {
{%- if values.add_model %}
  Future<List<${{ values.model_name | pascalcase }}>> get${{ values.entity_name | pascalcase if values.add_entity else 'Items' }}();
{%- else %}
  Future<List<Map<String, dynamic>>> getData();
{%- endif %}
}

@Injectable(as: ${{ values.datasource_name | pascalcase }})
class ${{ values.datasource_name | pascalcase }}Impl implements ${{ values.datasource_name | pascalcase }} {
  ${{ values.datasource_name | pascalcase }}Impl();

{%- if values.add_model %}
  @override
  Future<List<${{ values.model_name | pascalcase }}>> get${{ values.entity_name | pascalcase if values.add_entity else 'Items' }}() async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      ${{ values.model_name | pascalcase }}(
        id: '1',
        name: 'Sample ${{ values.entity_name | title if values.add_entity else 'Item' }}',
        description: 'This is a sample ${{ values.entity_name | lower if values.add_entity else 'item' }}',
      ),
    ];
  }
{%- else %}
  @override
  Future<List<Map<String, dynamic>>> getData() async {
    // Mock implementation - replace with actual API call
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      {
        'id': '1',
        'name': 'Sample Item',
        'description': 'This is a sample item',
      },
    ];
  }
{%- endif %}
}
{%- endif %}