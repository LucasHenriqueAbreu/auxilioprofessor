import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
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
    // Configurar o mock para lançar UserNotFoundException
    when(mockGetLoggedInUserUsecase.execute())
        .thenThrow(UserNotFoundException());

    await tester.pumpWidget(MaterialApp(
      home: NewPointRegistrationScreen(controller: controller),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    ));

    expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

    // Primeiro c1lique para simular o erro
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Verifica se o estado mudou para NewPointErrorState após o primeiro clique
    expect(controller.state.value, isA<NewPointErrorState>());
    expect(find.byType(LoginScreen),
        findsNothing); // Verifica se a tela de login não está presente

    // Segundo clique para simular o redirecionamento para o login após o erro
    final buttonGoToLogin = find.byType(ElevatedButton);
    await tester.tap(buttonGoToLogin);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen),
        findsOneWidget); // Verifica se a tela de login está presente
  });

  // testWidgets('Teste de erro de localização', (WidgetTester tester) async {
  //   // Configurar o mock para lançar LocalizationNotFoundException
  //   when(mockController.registerNewPoint())
  //       .thenThrow(LocalizationNotFoundException());

  //   await tester.pumpWidget(MaterialApp(
  //     home: NewPointRegistrationScreen(controller: mockController),
  //   ));

  //   expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

  //   await tester.tap(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   expect(find.text('Erro ao obter localização'), findsOneWidget);
  // });

  // testWidgets('Teste de sucesso', (WidgetTester tester) async {
  //   // Configurar o mock para não lançar erros
  //   when(mockController.registerNewPoint()).thenAnswer((_) async {});

  //   await tester.pumpWidget(MaterialApp(
  //     home: NewPointRegistrationScreen(controller: mockController),
  //   ));

  //   expect(find.byType(NewPointRegistrationScreen), findsOneWidget);

  //   await tester.tap(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   expect(find.byIcon(Icons.check_circle), findsOneWidget);
  // });
}
