
import 'package:auxilioprofessor/core/base/usecase/usecase_base.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';

class SaveNewPointInput {
  final int userId;
  final Localization localization;

  SaveNewPointInput({required this.userId, required this.localization});
}

class SaveNewPointUsecase extends UsecaseBase<SaveNewPointInput, void> {
  final PointRepository pointRepository;

  SaveNewPointUsecase({required this.pointRepository});
  
  @override
  Future<void> execute(SaveNewPointInput input) async {
    final newId = await pointRepository.getNextId();
    final ponto = Point(
      id: newId,
      userId: input.userId,
      time: DateTime.now(),
      localization: input.localization,
    );

    await pointRepository.salvarPonto(ponto);
  }
}