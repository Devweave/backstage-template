{% if values.add_entity %}
import 'package:flutter_test/flutter_test.dart';
import 'package:{{cookiecutter.project_name}}/features/${{ values.feature_name }}/domain/entities/${{ values.entity_name }}.dart';

void main() {
  group('${{ values.entity_name | pascalcase }} Entity', () {
    test('should create a valid ${{ values.entity_name }} with required fields', () {
      // Arrange
      const id = 'test-id';
      const name = 'Test ${{ values.entity_name | title }}';
      
      // Act
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: id,
        name: name,
      );
      
      // Assert
      expect(${{ values.entity_name }}.id, equals(id));
      expect(${{ values.entity_name }}.name, equals(name));
      expect(${{ values.entity_name }}.isActive, equals(false));
      expect(${{ values.entity_name }}.description, isNull);
    });

    test('should create a ${{ values.entity_name }} with all fields', () {
      // Arrange
      const id = 'test-id';
      const name = 'Test ${{ values.entity_name | title }}';
      const description = 'Test description';
      const isActive = true;
      final createdAt = DateTime.now();
      final updatedAt = DateTime.now();
      
      // Act
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: id,
        name: name,
        description: description,
        isActive: isActive,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      
      // Assert
      expect(${{ values.entity_name }}.id, equals(id));
      expect(${{ values.entity_name }}.name, equals(name));
      expect(${{ values.entity_name }}.description, equals(description));
      expect(${{ values.entity_name }}.isActive, equals(isActive));
      expect(${{ values.entity_name }}.createdAt, equals(createdAt));
      expect(${{ values.entity_name }}.updatedAt, equals(updatedAt));
    });

    test('should be valid when id and name are provided', () {
      // Arrange
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
      );
      
      // Act & Assert
      expect(${{ values.entity_name }}.isValid, isTrue);
    });

    test('should be invalid when id is empty', () {
      // Arrange
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: '',
        name: 'Test Name',
      );
      
      // Act & Assert
      expect(${{ values.entity_name }}.isValid, isFalse);
    });

    test('should be invalid when name is empty', () {
      // Arrange
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: '',
      );
      
      // Act & Assert
      expect(${{ values.entity_name }}.isValid, isFalse);
    });

    test('should return correct display name', () {
      // Arrange
      final ${{ values.entity_name }}WithName = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
      );
      
      final ${{ values.entity_name }}WithoutName = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: '',
      );
      
      // Act & Assert
      expect(${{ values.entity_name }}WithName.displayName, equals('Test Name'));
      expect(${{ values.entity_name }}WithoutName.displayName, equals('Unnamed ${{ values.entity_name | pascalcase }}'));
    });

    test('should create correct JSON for creation', () {
      // Arrange
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test description',
        isActive: true,
      );
      
      // Act
      final json = ${{ values.entity_name }}.toCreateJson();
      
      // Assert
      expect(json, equals({
        'name': 'Test Name',
        'description': 'Test description',
        'isActive': true,
      }));
    });

    test('should create correct JSON for update', () {
      // Arrange
      final ${{ values.entity_name }} = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test description',
        isActive: true,
      );
      
      // Act
      final json = ${{ values.entity_name }}.toUpdateJson();
      
      // Assert
      expect(json, equals({
        'id': 'test-id',
        'name': 'Test Name',
        'description': 'Test description',
        'isActive': true,
      }));
    });

    test('should support equality comparison', () {
      // Arrange
      final ${{ values.entity_name }}1 = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test description',
        isActive: true,
      );
      
      final ${{ values.entity_name }}2 = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Test Name',
        description: 'Test description',
        isActive: true,
      );
      
      final ${{ values.entity_name }}3 = ${{ values.entity_name | pascalcase }}(
        id: 'different-id',
        name: 'Test Name',
        description: 'Test description',
        isActive: true,
      );
      
      // Act & Assert
      expect(${{ values.entity_name }}1, equals(${{ values.entity_name }}2));
      expect(${{ values.entity_name }}1, isNot(equals(${{ values.entity_name }}3)));
    });

    test('should support copyWith', () {
      // Arrange
      final original = ${{ values.entity_name | pascalcase }}(
        id: 'test-id',
        name: 'Original Name',
        isActive: false,
      );
      
      // Act
      final updated = original.copyWith(
        name: 'Updated Name',
        isActive: true,
      );
      
      // Assert
      expect(updated.id, equals(original.id));
      expect(updated.name, equals('Updated Name'));
      expect(updated.isActive, isTrue);
      expect(updated.description, equals(original.description));
    });
  });
}
{% endif %}