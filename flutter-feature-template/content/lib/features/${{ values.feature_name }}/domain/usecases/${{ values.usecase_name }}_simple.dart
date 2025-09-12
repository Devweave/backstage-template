{%- if values.add_usecase %}
import 'package:flutter_boilerplate/core/utils/base_usecase.dart';
import 'package:flutter_boilerplate/core/utils/result.dart';
import 'package:injectable/injectable.dart';
{%- if values.add_entity %}
import '../entities/${{ values.entity_name }}.dart';
{%- endif %}
{%- if values.add_repository %}
import '../repositories/${{ values.repository_name }}.dart';
{%- endif %}

@injectable
class ${{ values.usecase_name | pascalcase }} implements BaseUseCase<{%- if values.add_entity %}List<${{ values.entity_name | pascalcase }}>{%- else %}List<Map<String, dynamic>>{%- endif %}, NoParams> {
{%- if values.add_repository %}
  final ${{ values.repository_name | pascalcase }} _repository;

  ${{ values.usecase_name | pascalcase }}(this._repository);
{%- else %}
  ${{ values.usecase_name | pascalcase }}();
{%- endif %}

  @override
  Future<Result<{%- if values.add_entity %}List<${{ values.entity_name | pascalcase }}>{%- else %}List<Map<String, dynamic>>{%- endif %}>> call(NoParams params) async {
{%- if values.add_repository and values.add_entity %}
    return await _repository.get${{ values.entity_name | pascalcase }}s();
{%- elif values.add_repository %}
    return await _repository.getData();
{%- else %}
    // Mock implementation - replace with actual logic
    {%- if values.add_entity %}
    final mockData = [
      ${{ values.entity_name | pascalcase }}(
        id: '1',
        name: 'Sample ${{ values.entity_name | title }}',
        description: 'This is a sample ${{ values.entity_name | lower }}',
      ),
    ];
    {%- else %}
    final mockData = [
      {
        'id': '1',
        'name': 'Sample Item',
        'description': 'This is a sample item',
      },
    ];
    {%- endif %}
    return Success(mockData);
{%- endif %}
  }
}
{%- endif %}