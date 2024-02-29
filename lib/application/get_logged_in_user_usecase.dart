

import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/core/base/usecase/usecase_base.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/domain/repositories/user_repository.dart';


class GetLoggedInUserUsecase extends UsecaseBaseWithOutInput<User> {
  final UserRepository userRepository;

  GetLoggedInUserUsecase({required this.userRepository});

  @override
  Future<User> execute() async {
    final user = await userRepository.getLoggedInUser();
    if (user == null) {
      throw UserNotFoundException();
    }
    return user;
  }
}
