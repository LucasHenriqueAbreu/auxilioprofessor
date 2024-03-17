import 'dart:async';

import 'package:auxilioprofessor/core/base/usecase/usecase_base.dart';
import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';

class GetPointsUsecase extends UsecaseBaseWithOutInput<Stream<List<Point>>> {
  final PointRepository _repository;
  GetPointsUsecase(this._repository);
  
  @override
  Future<Stream<List<Point>>> execute() async {
    return _repository.getPoints();
  }
}