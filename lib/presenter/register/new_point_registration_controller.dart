import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:flutter/foundation.dart';

enum RegistrationState { loading, success, error }

class NewPointRegistrationController extends ValueNotifier<RegistrationState> {
  final SaveNewPointUsecase saveNewPointUseCase;
  final GetLoggedInUserUsecase getLoggedInUserUseCase;
  final GetLocationUsecase getLocationUsecase;

  NewPointRegistrationController({
    required this.saveNewPointUseCase,
    required this.getLoggedInUserUseCase,
    required this.getLocationUsecase,
  }) : super(RegistrationState.loading);

  Future<void> registerNewPoint() async {
    try {
      value = RegistrationState.loading;
      final user = await getLoggedInUserUseCase.execute();
      final localization = await getLocationUsecase.execute();
      final input = SaveNewPointInput(userId: user.uid, localization: localization);
      await saveNewPointUseCase.execute(input);
      value = RegistrationState.success;
    } catch (e) {
      value = RegistrationState.error;
      rethrow;
    }
  }
}
