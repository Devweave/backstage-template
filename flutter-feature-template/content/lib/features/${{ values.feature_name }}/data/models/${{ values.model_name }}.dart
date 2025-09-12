{%- if values.add_model %}
import 'package:freezed_annotation/freezed_annotation.dart';
{%- if values.add_entity %}
import '../../domain/entities/${{ values.entity_name }}.dart';
{%- endif %}

part '${{ values.model_name }}.freezed.dart';
part '${{ values.model_name }}.g.dart';

@freezed
class ${{ values.model_name | pascalcase }} with _$${{ values.model_name | pascalcase }} {
  const factory ${{ values.model_name | pascalcase }}({
    required String id,
    required String name,
    String? description,
    @Default(false) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _${{ values.model_name | pascalcase }};

  factory ${{ values.model_name | pascalcase }}.fromJson(Map<String, dynamic> json) =>
      _$${{ values.model_name | pascalcase }}FromJson(json);
}

extension ${{ values.model_name | pascalcase }}Extension on ${{ values.model_name | pascalcase }} {
{%- if values.add_entity %}
  ${{ values.entity_name | pascalcase }} toEntity() {
    return ${{ values.entity_name | pascalcase }}(
      id: id,
      name: name,
      description: description,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
{%- endif %}

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'is_active': isActive,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      'is_active': isActive,
    };
  }
}

{%- if values.add_entity %}
extension ${{ values.entity_name | pascalcase }}ToModelExtension on ${{ values.entity_name | pascalcase }} {
  ${{ values.model_name | pascalcase }} toModel() {
    return ${{ values.model_name | pascalcase }}(
      id: id,
      name: name,
      description: description,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
{%- endif %}
{%- endif %}