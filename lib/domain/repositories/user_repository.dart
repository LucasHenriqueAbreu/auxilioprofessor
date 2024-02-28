// user_repository.dart


import 'package:auxilioprofessor/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<User?> getLoggedInUser();
}
