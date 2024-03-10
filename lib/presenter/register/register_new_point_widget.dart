import 'package:auxilioprofessor/presenter/register/new_point_registration_controller.dart';
import 'package:flutter/material.dart';

class NewPointRegistrationScreen extends StatelessWidget {
  final NewPointRegistrationController controller;

  const NewPointRegistrationScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Adicionar elementos de UI aqui
              ValueListenableBuilder<RegistrationState>(
                valueListenable: controller,
                builder: (context, state, _) {
                  switch (state) {
                    case RegistrationState.loading:
                      return const CircularProgressIndicator();
                    case RegistrationState.success:
                      return const Icon(Icons.check_circle,
                          color: Colors.green, size: 48);
                    case RegistrationState.error:
                      return const Icon(Icons.error, color: Colors.red, size: 48);
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await controller.registerNewPoint();
                },
                child: const Text('Registrar Ponto'),
              ),
            ],
          ),
        );
      },
    );
  }
}
