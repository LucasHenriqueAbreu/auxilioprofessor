import 'package:auxilioprofessor/application/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/presenter/splash_screen/splash_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'splash_screen_widget_test.mocks.dart';
import 'dart:async';

@GenerateMocks([GetLoggedInUserUsecase])
void main() {
  group('SplashScreen Widget Test', () {
    late MockGetLoggedInUserUsecase mockUseCase;
    final user = User(
        displayName: 'Test User',
        photoURL: 'https://example.com/photo.jpg',
        email: 'teste@teste.com',
        uid: '12312');

    setUp(() {
      mockUseCase = MockGetLoggedInUserUsecase();
    });

    testWidgets(
        'Loading state displays CircularProgressIndicator and render success before',
        (WidgetTester tester) async {
      final completer = Completer<User>();
      when(mockUseCase.execute()).thenAnswer((_) => completer.future);

      await tester.pumpWidget(
        MaterialApp(
          home: SplashScreen(getLoggedInUserUsecase: mockUseCase),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      completer.complete(user);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Bem-vindo, Test User!'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Error state displays error message',
        (WidgetTester tester) async {
      when(mockUseCase.execute()).thenThrow(UserNotFoundException());

      await tester.pumpWidget(MaterialApp(
        home: SplashScreen(getLoggedInUserUsecase: mockUseCase),
      ));

      expect(find.text('Error occurred. Please try again.'), findsOneWidget);
    });
  });
}
