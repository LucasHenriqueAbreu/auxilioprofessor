import 'package:auxilioprofessor/application/localization/geo_location_usecase.dart';
import 'package:auxilioprofessor/application/point/save_new_point_usecase.dart';
import 'package:auxilioprofessor/application/user/get_logged_in_user_usecase.dart';
import 'package:auxilioprofessor/domain/repositories/point_repository.dart';
import 'package:auxilioprofessor/domain/repositories/user_repository.dart';
import 'package:auxilioprofessor/infra/repositories/point_repository_memory.dart';
import 'package:auxilioprofessor/infra/repositories/user_repository_memory.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_controller.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('teste')),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRegisterScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openRegisterScreen() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final userRepository = UserRepositoryMemory();
        final getLoggedInUserUseCase = GetLoggedInUserUsecase(userRepository: userRepository);
        final pointRepository = PointRepositoryMemory();
        final saveNewPointUseCase = SaveNewPointUsecase(pointRepository: pointRepository);
        final getLocationUsecase = GetLocationUsecase();
        final controller = NewPointRegistrationController(saveNewPointUseCase: saveNewPointUseCase, getLoggedInUserUseCase: getLoggedInUserUseCase, getLocationUsecase: getLocationUsecase);
        return NewPointRegistrationScreen(controller: controller);
      },
    );
  }
}
