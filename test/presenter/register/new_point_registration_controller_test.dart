import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_controller.dart';
import 'package:auxilioprofessor/presenter/register/state/register_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'new_point_registration_controller_test.mocks.dart';

@GenerateMocks(
    [SaveNewPointUsecase, GetLoggedInUserUsecase, GetLocationUsecase])
void main() {
  late NewPointRegistrationController controller;
  late MockSaveNewPointUsecase mockSaveNewPointUsecase;
  late MockGetLoggedInUserUsecase mockGetLoggedInUserUsecase;
  late MockGetLocationUsecase mockGetLocationUsecase;

  setUp(() {
    mockSaveNewPointUsecase = MockSaveNewPointUsecase();
    mockGetLoggedInUserUsecase = MockGetLoggedInUserUsecase();
    mockGetLocationUsecase = MockGetLocationUsecase();

    controller = NewPointRegistrationController(
      saveNewPointUseCase: mockSaveNewPointUsecase,
      getLoggedInUserUseCase: mockGetLoggedInUserUsecase,
      getLocationUsecase: mockGetLocationUsecase,
    );
  });

  test('registerNewPoint - Success', () async {
    final user =
        User(uid: '1', displayName: 'Test User', email: '', photoURL: '');
    final localization = Localization(latitude: 0.0, longitude: 0.0);
    when(mockGetLoggedInUserUsecase.execute()).thenAnswer((_) async => user);
    when(mockGetLocationUsecase.execute())
        .thenAnswer((_) async => localization);
    when(mockSaveNewPointUsecase.execute(captureAny))
        .thenAnswer((_) async => Future<void>.value(null));
    await controller.registerNewPoint();
    expect(controller.state.value, isA<NewPointSuccessState>());
    verify(mockGetLoggedInUserUsecase.execute()).called(1);
    verify(mockGetLocationUsecase.execute()).called(1);
    verify(mockSaveNewPointUsecase.execute(captureAny)).called(1);
  });

  test('registerNewPoint - Error', () async {
    when(mockGetLoggedInUserUsecase.execute()).thenThrow(UserNotFoundException());
    await controller.registerNewPoint();
    expect(controller.state.value, isA<NewPointErrorState>());
    verify(mockGetLoggedInUserUsecase.execute()).called(1);
    verifyZeroInteractions(mockGetLocationUsecase);
    verifyZeroInteractions(mockSaveNewPointUsecase);
  });
}
