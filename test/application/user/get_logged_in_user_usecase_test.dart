// get_logged_in_user_usecase_test.dart

import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'get_logged_in_user_usecase_test.mocks.dart';


@GenerateMocks([UserRepository])
void main() {
  group('GetLoggedInUserUsecase', () {
    late GetLoggedInUserUsecase usecase;
    late MockUserRepository mockUserRepository;

    setUp(() {
      mockUserRepository = MockUserRepository();
      usecase = GetLoggedInUserUsecase(userRepository: mockUserRepository);
    });

    test('User found successfully', () async {
      // Arrange
      final user = User(
        uid: 'uid1',
        email: 'user1@example.com',
        displayName: 'User One',
        photoURL: 'https://example.com/user1.jpg',
      );
      when(mockUserRepository.getLoggedInUser()).thenAnswer((_) async => user);

      // Act
      final result = await usecase.execute();

      // Assert
      expect(result, equals(user));
    });

    test('User not found', () async {
      // Arrange
      when(mockUserRepository.getLoggedInUser()).thenAnswer((_) async => null);

      // Act & Assert
      expect(() => usecase.execute(), throwsA(isA<UserNotFoundException>()));
    });
  });
}
