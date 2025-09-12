{% if values.add_bloc %}
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/utils/resource_status.dart';
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/utils/result.dart';
import 'package:${{ values.appName | lower | replace(' ', '_') }}/core/error/failures.dart';
{% if values.add_entity %}
import 'package:{{cookiecutter.project_name}}/features/${{ values.feature_name }}/domain/entities/${{ values.entity_name }}.dart';
{% endif %}
{% if values.add_usecase %}
import 'package:{{cookiecutter.project_name}}/features/${{ values.feature_name }}/domain/usecases/${{ values.usecase_name }}.dart';
{% endif %}
import 'package:{{cookiecutter.project_name}}/features/${{ values.feature_name }}/presentation/bloc/${{ values.bloc_name }}_bloc.dart';

import '${{ values.bloc_name }}_bloc_test.mocks.dart';

@GenerateMocks([
{% if values.add_usecase %}
  ${{ values.usecase_name | pascalcase }},
  Get${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase,
  Create${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
  Update${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
  Delete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
{% endif %}
])
void main() {
  group('${{ values.bloc_name | pascalcase }}Bloc', () {
{% if values.add_usecase %}
    late Mock${{ values.usecase_name | pascalcase }} mock${{ values.usecase_name | pascalcase }};
    late MockGet${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase mockGet${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase;
    late MockCreate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase mockCreate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase;
    late MockUpdate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase mockUpdate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase;
    late MockDelete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase mockDelete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase;
{% endif %}
    late ${{ values.bloc_name | pascalcase }}Bloc bloc;

    {% if values.add_entity %}
    const test${{ values.entity_name | pascalcase }} = ${{ values.entity_name | pascalcase }}(
      id: 'test-id',
      name: 'Test ${{ values.entity_name | title }}',
      description: 'Test description',
      isActive: true,
    );

    const test${{ values.entity_name | pascalcase }}List = [test${{ values.entity_name | pascalcase }}];
    {% endif %}

    setUp(() {
{% if values.add_usecase %}
      mock${{ values.usecase_name | pascalcase }} = Mock${{ values.usecase_name | pascalcase }}();
      mockGet${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase = MockGet${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase();
      mockCreate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase = MockCreate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase();
      mockUpdate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase = MockUpdate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase();
      mockDelete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase = MockDelete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase();

      bloc = ${{ values.bloc_name | pascalcase }}Bloc(
        mock${{ values.usecase_name | pascalcase }},
        mockGet${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}ByIdUseCase,
        mockCreate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
        mockUpdate${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
        mockDelete${{ values.entity_name | pascalcase if values.add_entity else 'Item' }}UseCase,
      );
{% else %}
      bloc = ${{ values.bloc_name | pascalcase }}Bloc();
{% endif %}
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(${{ values.bloc_name | pascalcase }}State.initial()));
    });

    group('{% if values.add_entity %}Load${{ values.entity_name | pascalcase }}s{% else %}LoadItems{% endif %}', () {
{% if values.add_usecase %}
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, success] when {% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %} succeeds',
        build: () {
          when(mock${{ values.usecase_name | pascalcase }}(any))
              .thenAnswer((_) async => {% if values.add_entity %}const Success(test${{ values.entity_name | pascalcase }}List){% else %}const Success([]){% endif %});
          return bloc;
        },
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.{% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %}()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.loading && state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.success && 
            !state.isLoading &&
            {% if values.add_entity %}state.${{ values.entity_name }}s == test${{ values.entity_name | pascalcase }}List{% else %}state.items.isEmpty{% endif %}),
        ],
      );

      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, error] when {% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %} fails',
        build: () {
          when(mock${{ values.usecase_name | pascalcase }}(any))
              .thenAnswer((_) async => const Error(ServerFailure('Server error')));
          return bloc;
        },
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.{% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %}()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.loading && state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.error && 
            !state.isLoading &&
            state.errorMessage == 'Server error'),
        ],
      );
{% else %}
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, success] when {% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %} is called',
        build: () => bloc,
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.{% if values.add_entity %}load${{ values.entity_name | pascalcase }}s{% else %}loadItems{% endif %}()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.loading && state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.status == ResourceStatus.success && !state.isLoading),
        ],
      );
{% endif %}
    });

    {% if values.add_entity %}
    group('Create${{ values.entity_name | pascalcase }}', () {
{% if values.add_usecase %}
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, success] when create${{ values.entity_name | pascalcase }} succeeds',
        build: () {
          when(mockCreate${{ values.entity_name | pascalcase }}UseCase(any))
              .thenAnswer((_) async => const Success(test${{ values.entity_name | pascalcase }}));
          return bloc;
        },
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          status: ResourceStatus.success,
          ${{ values.entity_name }}s: [],
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.create${{ values.entity_name | pascalcase }}(test${{ values.entity_name | pascalcase }})),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            !state.isLoading &&
            state.${{ values.entity_name }}s.contains(test${{ values.entity_name | pascalcase }})),
        ],
      );
{% endif %}
    });

    group('Update${{ values.entity_name | pascalcase }}', () {
{% if values.add_usecase %}
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, success] when update${{ values.entity_name | pascalcase }} succeeds',
        build: () {
          const updated${{ values.entity_name | pascalcase }} = ${{ values.entity_name | pascalcase }}(
            id: 'test-id',
            name: 'Updated Name',
            description: 'Updated description',
            isActive: false,
          );
          when(mockUpdate${{ values.entity_name | pascalcase }}UseCase(any))
              .thenAnswer((_) async => const Success(updated${{ values.entity_name | pascalcase }}));
          return bloc;
        },
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          status: ResourceStatus.success,
          ${{ values.entity_name }}s: test${{ values.entity_name | pascalcase }}List,
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.update${{ values.entity_name | pascalcase }}(test${{ values.entity_name | pascalcase }})),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            !state.isLoading &&
            state.${{ values.entity_name }}s.first.name == 'Updated Name'),
        ],
      );
{% endif %}
    });

    group('Delete${{ values.entity_name | pascalcase }}', () {
{% if values.add_usecase %}
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits [loading, success] when delete${{ values.entity_name | pascalcase }} succeeds',
        build: () {
          when(mockDelete${{ values.entity_name | pascalcase }}UseCase(any))
              .thenAnswer((_) async => const Success(null));
          return bloc;
        },
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          status: ResourceStatus.success,
          ${{ values.entity_name }}s: test${{ values.entity_name | pascalcase }}List,
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.delete${{ values.entity_name | pascalcase }}('test-id')),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => state.isLoading),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            !state.isLoading &&
            state.${{ values.entity_name }}s.isEmpty),
        ],
      );
{% endif %}
    });

    group('Select${{ values.entity_name | pascalcase }}', () {
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits correct state when select${{ values.entity_name | pascalcase }} is called',
        build: () => bloc,
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.select${{ values.entity_name | pascalcase }}(test${{ values.entity_name | pascalcase }})),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.selected${{ values.entity_name | pascalcase }} == test${{ values.entity_name | pascalcase }}),
        ],
      );
    });
    {% endif %}

    group('Search', () {
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits correct state when search is called',
        build: () => bloc,
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          status: ResourceStatus.success,
          {% if values.add_entity %}${{ values.entity_name }}s: test${{ values.entity_name | pascalcase }}List{% else %}items: []{% endif %},
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.search('test')),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.searchQuery == 'test'),
        ],
      );

      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits correct state when clearSearch is called',
        build: () => bloc,
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          searchQuery: 'test',
          {% if values.add_entity %}filtered${{ values.entity_name | pascalcase }}s: []{% else %}filteredItems: []{% endif %},
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.clearSearch()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            state.searchQuery == null &&
            {% if values.add_entity %}state.filtered${{ values.entity_name | pascalcase }}s.isEmpty{% else %}state.filteredItems.isEmpty{% endif %}),
        ],
      );
    });

    group('ClearSelection', () {
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits correct state when clearSelection is called',
        build: () => bloc,
        seed: () => ${{ values.bloc_name | pascalcase }}State.initial().copyWith(
          {% if values.add_entity %}selected${{ values.entity_name | pascalcase }}: test${{ values.entity_name | pascalcase }}{% else %}selectedItem: {}{% endif %},
        ),
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.clearSelection()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => 
            {% if values.add_entity %}state.selected${{ values.entity_name | pascalcase }} == null{% else %}state.selectedItem == null{% endif %}),
        ],
      );
    });

    group('Refresh', () {
      blocTest<${{ values.bloc_name | pascalcase }}Bloc, ${{ values.bloc_name | pascalcase }}State>(
        'emits correct state when refresh is called',
        build: () => bloc,
        act: (bloc) => bloc.add(const ${{ values.bloc_name | pascalcase }}Event.refresh()),
        expect: () => [
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => state.isRefreshing),
          predicate<${{ values.bloc_name | pascalcase }}State>((state) => !state.isRefreshing),
        ],
      );
    });
  });
}
{% endif %}