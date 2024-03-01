// Entidade para representar o ponto
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';

class Point {
  final int id;
  final String userId;
  final DateTime time;
  final Localization localization;

  Point({
    required this.id,
    required this.userId,
    required this.time,
    required this.localization,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Point &&
        other.id == id &&
        other.userId == userId &&
        other.time == time &&
        other.localization == localization;
  }

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ time.hashCode ^ localization.hashCode;
}