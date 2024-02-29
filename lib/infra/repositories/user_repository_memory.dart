import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/domain/repositories/user_repository.dart';

class UserRepositoryMemory extends UserRepository {
  @override
  Future<User?> getLoggedInUser() {
    return Future.delayed(
      const Duration(seconds: 5),
      () => User(
        uid: '123',
        email: 'teste@teste.com',
        displayName: 'Teste',
        photoURL: 'http:asdfas',
      ),
    );
  }
}
