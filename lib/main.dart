import 'package:auxilioprofessor/application/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/infra/repositories/user_repository_memory.dart';
import 'package:auxilioprofessor/presenter/splash_screen/splash_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(
        getLoggedInUserUsecase: GetLoggedInUserUsecase(
          userRepository: UserRepositoryMemory(),
        ),
      ),
    );
  }
}
