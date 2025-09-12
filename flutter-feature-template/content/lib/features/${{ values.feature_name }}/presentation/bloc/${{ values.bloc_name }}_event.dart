{%- if values.add_bloc %}
part of '${{ values.bloc_name }}_bloc.dart';

@freezed
abstract class ${{ values.bloc_name | pascalcase }}Event with _$${{ values.bloc_name | pascalcase }}Event {
{%- if values.add_entity %}
  // Get all items
  const factory ${{ values.bloc_name | pascalcase }}Event.get${{ values.feature_name | pascalcase }}() = _Get${{ values.feature_name | pascalcase }};
{%- else %}
  // Get all items
  const factory ${{ values.bloc_name | pascalcase }}Event.get${{ values.feature_name | pascalcase }}() = _Get${{ values.feature_name | pascalcase }};
{%- endif %}
}
{%- endif %}