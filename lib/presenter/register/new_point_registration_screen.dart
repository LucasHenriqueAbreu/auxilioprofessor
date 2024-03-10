import 'package:auxilioprofessor/core/base/errors/user_not_found_exception.dart';
import 'package:auxilioprofessor/presenter/register/new_point_registration_controller.dart';
import 'package:auxilioprofessor/presenter/register/state/register_state.dart';
import 'package:flutter/material.dart';

class NewPointRegistrationScreen extends StatefulWidget {
  final NewPointRegistrationController controller;

  const NewPointRegistrationScreen({super.key, required this.controller});

  @override
  State<NewPointRegistrationScreen> createState() =>
      _NewPointRegistrationScreenState();
}

class _NewPointRegistrationScreenState
    extends State<NewPointRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return ValueListenableBuilder<NewPointState>(
          valueListenable: widget.controller.state,
          builder: (context, state, _) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildContent(state),
                  const SizedBox(height: 16),
                  state is! NewPointErrorState
                      ? ElevatedButton(
                          onPressed: () async {
                            await widget.controller.registerNewPoint();
                          },
                          child: const Text('Registrar Ponto'),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContent(NewPointState state) {
    if (state is NewPointLoadingState) {
      return const CircularProgressIndicator();
    }
    if (state is NewPointSuccessState) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 48);
    }
    if (state is NewPointErrorState) {
      return Column(
        children: [
          Text(state.error.toString()),
          const Icon(Icons.error, color: Colors.red, size: 48),
          state.error is UserNotFoundException
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Go to login'))
              : const SizedBox.shrink(),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
