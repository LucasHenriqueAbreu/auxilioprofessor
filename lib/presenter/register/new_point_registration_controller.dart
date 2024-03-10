import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/presenter/register/state/register_state.dart';
import 'package:flutter/foundation.dart';

class NewPointRegistrationController {
  final SaveNewPointUsecase saveNewPointUseCase;
  final GetLoggedInUserUsecase getLoggedInUserUseCase;
  final GetLocationUsecase getLocationUsecase;

  final ValueNotifier<NewPointState> _stateNotifier =
      ValueNotifier(NewPointLoadingState());

  NewPointRegistrationController({
    required this.saveNewPointUseCase,
    required this.getLoggedInUserUseCase,
    required this.getLocationUsecase,
  });

  void _setState(NewPointState newState) {
    _stateNotifier.value = newState;
  }

  ValueNotifier<NewPointState> get state => _stateNotifier;

  Future<void> registerNewPoint() async {
    try {
      _setState(NewPointLoadingState());
      final user = await getLoggedInUserUseCase.execute();
      final localization = await getLocationUsecase.execute();
      final input =
          SaveNewPointInput(userId: user.uid, localization: localization);
      await saveNewPointUseCase.execute(input);
      _setState(NewPointSuccessState());
    } catch (e) {
      _setState(NewPointErrorState(e as Exception));
    }
  }
}
