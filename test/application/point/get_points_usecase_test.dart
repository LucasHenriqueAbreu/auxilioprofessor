import 'dart:async';

import 'package:auxilioprofessor/application/point/get_points_usecase.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_new_point_usecase_test.mocks.dart';

@GenerateMocks([PointRepository])
void main() {
  late MockPointRepository mockRepository;
  late GetPointsUsecase usecase;

  setUp(() {
    mockRepository = MockPointRepository();
    usecase = GetPointsUsecase(mockRepository);
  });

  test('execute should return a stream of list of points', () async {
    final expectedPoints = Stream<List<Point>>.fromIterable([
      [
        Point(
          id: 1,
          userId: 'user_id_1',
          time: DateTime.now(),
          localization: Localization(latitude: 0.0, longitude: 0.0),
        ),
        Point(
          id: 2,
          userId: 'user_id_2',
          time: DateTime.now(),
          localization: Localization(latitude: 0.0, longitude: 0.0),
        ),
      ]
    ]);

    when(mockRepository.getPoints()).thenAnswer((_) => expectedPoints);
    final result = await usecase.execute();
    expect(result, equals(expectedPoints));
    verify(mockRepository.getPoints()).called(1);
  });
}
