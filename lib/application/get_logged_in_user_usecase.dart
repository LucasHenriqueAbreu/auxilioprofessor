

import 'package:auxilioprofessor/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/base/usecase/usecase_base.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/domain/repositories/user_repository.dart';


class GetLoggedInUserUsecase extends UsecaseBase<void, User> {
  final UserRepository userRepository;

  GetLoggedInUserUsecase({required this.userRepository});

  @override
  Future<User> execute({void input}) async {
    final user = await userRepository.getLoggedInUser();
    if (user == null) {
      throw UserNotFoundException();
    }
    return user;
  }
}
