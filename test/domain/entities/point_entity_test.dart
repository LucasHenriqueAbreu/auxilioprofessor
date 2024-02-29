
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  // Testes para a entidade Point
  test('Teste Point - igualdade', () {
    final time = DateTime.now();
    final localization1 = Localization(latitude: 40.7128, longitude: -74.0060);
    final localization2 = Localization(latitude: 37.7749, longitude: -122.4194);

    final ponto1 = Point(id: 1, userId: 1, time: time, localization: localization1);
    final ponto2 = Point(id: 1, userId: 1, time: time, localization: localization1);
    final ponto3 = Point(id: 2, userId: 1, time: time, localization: localization1);
    final ponto4 = Point(id: 1, userId: 2, time: time, localization: localization1);
    final ponto5 = Point(id: 1, userId: 1, time: time, localization: localization2);

    expect(ponto1, equals(ponto2));
    expect(ponto1, isNot(equals(ponto3)));
    expect(ponto1, isNot(equals(ponto4)));
    expect(ponto1, isNot(equals(ponto5)));
  });
}