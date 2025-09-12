{%- if values.add_bloc %}
part of '${{ values.bloc_name }}_bloc.dart';

@freezed
abstract class ${{ values.bloc_name | pascalcase }}State with _$${{ values.bloc_name | pascalcase }}State {
{%- if values.add_entity %}
  const factory ${{ values.bloc_name | pascalcase }}State({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default([]) List<${{ values.entity_name | pascalcase }}> ${{ values.entity_name }}s,
    String? errorMessage,
  }) = _${{ values.bloc_name | pascalcase }}State;

  factory ${{ values.bloc_name | pascalcase }}State.initial() => const ${{ values.bloc_name | pascalcase }}State();
{%- else %}
  const factory ${{ values.bloc_name | pascalcase }}State({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    @Default([]) List<Map<String, dynamic>> items,
    String? errorMessage,
  }) = _${{ values.bloc_name | pascalcase }}State;

  factory ${{ values.bloc_name | pascalcase }}State.initial() => const ${{ values.bloc_name | pascalcase }}State();
{%- endif %}
}
{%- endif %}