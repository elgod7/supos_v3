import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/constants/app_strings.dart';

import '../../bloc/auth_bloc.dart';

class SigninScreen extends StatelessWidget {
  final VoidCallback onToggle;

  SigninScreen({super.key, required this.onToggle});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(AppStrings.login, style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(labelText: AppStrings.email),
            controller: emailController,
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: const InputDecoration(labelText: AppStrings.password),
            obscureText: true,
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoginRequested(
                  emailController.text, passwordController.text));
                 
            },
            child: const Text(AppStrings.login),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onToggle,
            child: const Text(AppStrings.doNotHaveAnAccount),
          ),
        ],
      ),
    );
  }
}
