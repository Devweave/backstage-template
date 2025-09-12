{%- if values.add_entity %}
import 'package:freezed_annotation/freezed_annotation.dart';

part '${{ values.entity_name }}.freezed.dart';
part '${{ values.entity_name }}.g.dart';

@freezed
class ${{ values.entity_name | pascalcase }} with _$${{ values.entity_name | pascalcase }} {
  const factory ${{ values.entity_name | pascalcase }}({
    required String id,
    required String name,
    String? description,
    @Default(false) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _${{ values.entity_name | pascalcase }};

  factory ${{ values.entity_name | pascalcase }}.fromJson(Map<String, dynamic> json) =>
      _$${{ values.entity_name | pascalcase }}FromJson(json);
}

extension ${{ values.entity_name | pascalcase }}Extension on ${{ values.entity_name | pascalcase }} {
  bool get isValid => id.isNotEmpty && name.isNotEmpty;
  
  String get displayName => name.isNotEmpty ? name : 'Unnamed ${{ values.entity_name | pascalcase }}';
  
  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'isActive': isActive,
    };
  }
  
  Map<String, dynamic> toUpdateJson() {
    return {
      'id': id,
      'name': name,
      if (description != null) 'description': description,
      'isActive': isActive,
    };
  }
}
{%- endif %}