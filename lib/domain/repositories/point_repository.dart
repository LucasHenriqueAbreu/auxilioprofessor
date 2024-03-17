import 'package:auxilioprofessor/domain/entities/point.dart';

abstract class PointRepository {
  Future<void> salvarPonto(Point point);
  Future<int> getNextId();
  Stream<List<Point>> getPoints();
}
