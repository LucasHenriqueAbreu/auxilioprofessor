import 'package:auxilioprofessor/domain/entities/point.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';

class PointRepositoryMemory extends PointRepository {
  final List<Point> _points = [];
  @override
  Future<int> getNextId() async {
    return _points.length;
  }

  @override
  Future<void> salvarPonto(Point point) async {
    _points.add(point);
  }
}