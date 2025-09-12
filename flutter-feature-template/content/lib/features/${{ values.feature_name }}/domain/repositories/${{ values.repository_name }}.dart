{%- if values.add_repository %}
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/utils/result.dart';
{%- if values.add_entity %}
import '../entities/${{ values.entity_name }}.dart';
{%- endif %}

abstract class ${{ values.repository_name | pascalcase }} {
{%- if values.add_entity %}
  Future<Result<List<${{ values.entity_name | pascalcase }}>>> get${{ values.entity_name | pascalcase }}s();
{%- else %}
  Future<Result<List<Map<String, dynamic>>>> getData();
{%- endif %}
}
{%- endif %}