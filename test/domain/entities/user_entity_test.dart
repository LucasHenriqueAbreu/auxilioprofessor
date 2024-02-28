// user_entity_test.dart

import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserEntity', () {
    test('Shold be a instance of User', () {
      final user1 = User(
        uid: 'uid1',
        email: 'user1@example.com',
        displayName: 'User One',
        photoURL: 'https://example.com/user1.jpg',
      );
      expect(user1, isA<User>());
    });
    test('Equality: Two identical users should be equal', () {
      // Arrange
      final user1 = User(
        uid: 'uid1',
        email: 'user1@example.com',
        displayName: 'User One',
        photoURL: 'https://example.com/user1.jpg',
      );
      final user2 = User(
        uid: 'uid1',
        email: 'user1@example.com',
        displayName: 'User One',
        photoURL: 'https://example.com/user1.jpg',
      );

      // Act & Assert
      expect(user1 == user2, true); // Both users should be equal
    });

    test('Equality: Two different users should not be equal', () {
      // Arrange
      final user1 = User(
        uid: 'uid1',
        email: 'user1@example.com',
        displayName: 'User One',
        photoURL: 'https://example.com/user1.jpg',
      );
      final user2 = User(
        uid: 'uid2',
        email: 'user2@example.com',
        displayName: 'User Two',
        photoURL: 'https://example.com/user2.jpg',
      );

      // Act & Assert
      expect(user1 == user2, false);
    });
  });
}
