import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'save_new_point_usecase_test.mocks.dart';

@GenerateMocks([PointRepository])
void main() {
  group('SaveNewPointUsecase', () {
    late SaveNewPointUsecase saveNewPointUsecase;
    late MockPointRepository mockPointRepository;

    setUp(() {
      mockPointRepository = MockPointRepository();
      saveNewPointUsecase =
          SaveNewPointUsecase(pointRepository: mockPointRepository);
    });

    test('Deve chamar getNextId e salvarPonto corretamente', () async {
      const userId = '1';
      final localization = Localization(latitude: 40.7128, longitude: -74.0060);
      final input =
          SaveNewPointInput(userId: userId, localization: localization);
      const newId = 100;

      when(mockPointRepository.getNextId()).thenAnswer((_) async => newId);
      when(mockPointRepository.salvarPonto(captureAny)).thenAnswer((_) async => Future<void>.value(null));
      
      await saveNewPointUsecase.execute(input);

      verify(mockPointRepository.getNextId()).called(1);
      verify(mockPointRepository.salvarPonto(captureAny)).called(1);
    });

    test('Deve lançar uma exceção se getNextId falhar', () async {
      const userId = '1';
      final localization = Localization(latitude: 40.7128, longitude: -74.0060);
      final input =
          SaveNewPointInput(userId: userId, localization: localization);

      when(mockPointRepository.getNextId())
          .thenThrow(Exception('Erro ao obter próximo ID'));

      expect(() async => await saveNewPointUsecase.execute(input),
          throwsException);
    });
  });
}
