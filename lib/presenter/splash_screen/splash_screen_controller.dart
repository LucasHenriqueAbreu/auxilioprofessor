import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';

enum SplashScreenState { loading, success, error }

class SplashScreenController extends ChangeNotifier {
  final ValueNotifier<SplashScreenState> state = ValueNotifier<SplashScreenState>(SplashScreenState.loading);
  final GetLoggedInUserUsecase getLoggedInUserUsecase;
  late User _user;

  SplashScreenController({required this.getLoggedInUserUsecase});

  User get user => _user;

  void init() async {
    try {
      _user = await getLoggedInUserUsecase.execute();
      _setState(SplashScreenState.success);
    } on UserNotFoundException {
      _setState(SplashScreenState.error);
    }
  }

  void _setState(SplashScreenState newState) {
    state.value = newState;
  }
}
