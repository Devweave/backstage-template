{%- if values.add_repository_impl %}
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/error/failures.dart';
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/utils/result.dart';
import 'package:injectable/injectable.dart';
{%- if values.add_entity %}
import '../../domain/entities/${{ values.entity_name }}.dart';
{%- endif %}
{%- if values.add_repository %}
import '../../domain/repositories/${{ values.repository_name }}.dart';
{%- endif %}
{%- if values.add_datasource %}
import '../datasources/${{ values.datasource_name }}.dart';
{%- endif %}

{%- if values.add_repository %}
@Injectable(as: ${{ values.repository_name | pascalcase }})
class ${{ values.repository_name | pascalcase }}Impl implements ${{ values.repository_name | pascalcase }} {
{%- else %}
@Injectable()
class ${{ values.feature_name | pascalcase }}RepositoryImpl {
{%- endif %}
{%- if values.add_datasource %}
  final ${{ values.datasource_name | pascalcase }} _dataSource;

  ${{ values.repository_name | pascalcase if values.add_repository else values.feature_name | pascalcase }}{%- if not values.add_repository %}Repository{%- endif %}Impl(this._dataSource);
{%- else %}
  ${{ values.repository_name | pascalcase if values.add_repository else values.feature_name | pascalcase }}{%- if not values.add_repository %}Repository{%- endif %}Impl();
{%- endif %}

{%- if values.add_entity %}
  @override
  Future<Result<List<${{ values.entity_name | pascalcase }}>>> get${{ values.entity_name | pascalcase }}s() async {
    try {
{%- if values.add_datasource %}
      final models = await _dataSource.get${{ values.entity_name | pascalcase }}s();
      final entities = models.map((model) => model.toEntity()).toList();
      return Success(entities);
{%- else %}
      // Mock implementation - replace with actual logic
      final mockData = [
        ${{ values.entity_name | pascalcase }}(
          id: '1',
          name: 'Sample ${{ values.entity_name | title }}',
          description: 'This is a sample ${{ values.entity_name | lower }}',
        ),
      ];
      return Success(mockData);
{%- endif %}
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
{%- else %}
  @override
  Future<Result<List<Map<String, dynamic>>>> getData() async {
    try {
{%- if values.add_datasource %}
      final data = await _dataSource.getData();
      return Success(data);
{%- else %}
      // Mock implementation - replace with actual logic
      final mockData = [
        {
          'id': '1',
          'name': 'Sample Item',
          'description': 'This is a sample item',
        },
      ];
      return Success(mockData);
{%- endif %}
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
{%- endif %}
}
{%- endif %}