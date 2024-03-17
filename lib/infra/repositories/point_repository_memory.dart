import 'dart:async';

import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';

class PointRepositoryMemory extends PointRepository {
  final StreamController<List<Point>> _pointsController =
      StreamController<List<Point>>.broadcast();
  final List<Point> _points = [];

  @override
  Future<int> getNextId() async {
    return _points.length;
  }

  @override
  Future<void> salvarPonto(Point point) async {
    _points.add(point);
    _pointsController.add(_points);
  }

  @override
  Stream<List<Point>> getPoints() {
    return _pointsController.stream;
  }
}
