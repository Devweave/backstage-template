{% if values.add_bloc %}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
{% if values.add_entity %}
import '../../domain/entities/${{ values.entity_name }}.dart';
{% endif %}
{% if values.add_usecase %}
import '../../domain/usecases/${{ values.usecase_name }}.dart';
{% endif %}

part '${{ values.bloc_name }}_event.dart';
part '${{ values.bloc_name }}_state.dart';
part '${{ values.bloc_name }}_bloc.freezed.dart';

@injectable
class ${{ values.bloc_name | pascalcase }}Bloc extends Bloc<${{ values.bloc_name | pascalcase }}Event, ${{ values.bloc_name | pascalcase }}State> {
{% if values.add_usecase %}
  final ${{ values.usecase_name | pascalcase }} _${{ values.usecase_name }};

  ${{ values.bloc_name | pascalcase }}Bloc(this._${{ values.usecase_name }}) : super(${{ values.bloc_name | pascalcase }}State.initial()) {
{% else %}
  ${{ values.bloc_name | pascalcase }}Bloc() : super(${{ values.bloc_name | pascalcase }}State.initial()) {
{% endif %}
    on<_Get${{ values.feature_name | pascalcase }}>(_onGet${{ values.feature_name | pascalcase }});
  }

  Future<void> _onGet${{ values.feature_name | pascalcase }}(
    _Get${{ values.feature_name | pascalcase }} event,
    Emitter<${{ values.bloc_name | pascalcase }}State> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isError: false));

    try {
{% if values.add_usecase %}
      final result = await _${{ values.usecase_name }}();
      result.fold(
        (failure) => emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: failure.message,
        )),
        ({% if values.add_entity %}${{ values.entity_name }}s{% else %}items{% endif %}) => emit(state.copyWith(
          isLoading: false,
          isError: false,
          {% if values.add_entity %}${{ values.entity_name }}s: ${{ values.entity_name }}s{% else %}items: items{% endif %},
        )),
      );
{% else %}
      // Mock data - replace with actual data fetching
      await Future.delayed(const Duration(seconds: 1));
      
      {% if values.add_entity %}
      final mockData = [
        ${{ values.entity_name | pascalcase }}(
          id: '1',
          name: 'Sample ${{ values.entity_name | title }}',
          description: 'This is a sample ${{ values.entity_name | lower }}',
        ),
      ];
      {% else %}
      final mockData = [
        {
          'id': '1',
          'name': 'Sample Item',
          'description': 'This is a sample item',
        },
      ];
      {% endif %}

      emit(state.copyWith(
        isLoading: false,
        isError: false,
        {% if values.add_entity %}${{ values.entity_name }}s: mockData{% else %}items: mockData{% endif %},
      ));
{% endif %}
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
{% endif %}