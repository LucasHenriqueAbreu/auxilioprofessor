import 'package:auxilioprofessor/application/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/domain/entities/user_entity.dart';
import 'package:auxilioprofessor/presenter/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final GetLoggedInUserUsecase getLoggedInUserUsecase;
  const SplashScreen({super.key, required this.getLoggedInUserUsecase});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SplashScreenController(
      getLoggedInUserUsecase: widget.getLoggedInUserUsecase,
    );
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ValueListenableBuilder<SplashScreenState>(
      valueListenable: _controller.state,
      builder: (context, state, _) {
        if (state == SplashScreenState.loading) {
          return const CircularProgressIndicator();
        }
        if (state == SplashScreenState.success) {
          return _buildSuccessUI(_controller.user);
        }
        if (state == SplashScreenState.error) {
          return const Text('Error occurred. Please try again.');
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSuccessUI(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CircleAvatar( // Quando eu descobrir como testa 
        //   radius: 50,
        //   backgroundImage: NetworkImage(user.photoURL),
        // ),
        const SizedBox(height: 16),
        Text(
          'Bem-vindo, ${user.displayName}!',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: const Text('Ir para a Home'),
        ),
      ],
    );
  }
}
