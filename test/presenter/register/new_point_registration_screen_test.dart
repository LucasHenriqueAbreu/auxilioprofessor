import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/core/base/errors/localization_not_found_exception.dart';
import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/domain/entities/localization_entity.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/presenter/login/login_screen.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_controller.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_screen.dart';
import 'package:auxilioprofessor/presenter/register/state/register_state.dart';
import 'package:flutter/material.dart';
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

  testWidgets('Teste de erro de login', (WidgetTester tester) async {
    when(mockGetLoggedInUserUsecase.execute())
        .thenThrow(UserNotFoundException());

    await tester.pumpWidget(MaterialApp(
      home: NewPointRegistrationScreen(controller: controller),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    ));

    expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(controller.state.value, isA<NewPointErrorState>());
    expect(find.byType(LoginScreen), findsNothing);
    final buttonGoToLogin = find.byType(ElevatedButton);
    await tester.tap(buttonGoToLogin);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Teste de erro de localização', (WidgetTester tester) async {
    final user =
        User(uid: '1', displayName: 'Test User', email: '', photoURL: '');
    when(mockGetLoggedInUserUsecase.execute()).thenAnswer((_) async => user);
    when(mockGetLocationUsecase.execute()).thenThrow(LocalizationNotFoundException());

    await tester.pumpWidget(MaterialApp(
      home: NewPointRegistrationScreen(controller: controller),
    ));

    expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.error), findsOneWidget);
  });

  testWidgets('Teste de sucesso', (WidgetTester tester) async {
     final user =
        User(uid: '1', displayName: 'Test User', email: '', photoURL: '');
    final localization = Localization(latitude: 0.0, longitude: 0.0);
    when(mockGetLoggedInUserUsecase.execute()).thenAnswer((_) async => user);
    when(mockGetLocationUsecase.execute())
        .thenAnswer((_) async => localization);
    when(mockSaveNewPointUsecase.execute(captureAny))
        .thenAnswer((_) async => Future<void>.value(null));

    await tester.pumpWidget(MaterialApp(
      home: NewPointRegistrationScreen(controller: controller),
    ));
    expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    expect(controller.state.value, isA<NewPointSuccessState>());
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}
