import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Testes para a entidade Localization
  test('Teste Localization - igualdade', () {
    final localizacao1 = Localization(latitude: 40.7128, longitude: -74.0060);
    final localizacao2 = Localization(latitude: 40.7128, longitude: -74.0060);
    final localizacao3 = Localization(latitude: 37.7749, longitude: -122.4194);

    expect(localizacao1, equals(localizacao2));
    expect(localizacao1, isNot(equals(localizacao3)));
  });

  
}