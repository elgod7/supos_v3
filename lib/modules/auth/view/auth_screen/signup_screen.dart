import 'package:flutter/material.dart';
import 'package:supos_v3/modules/auth/bloc/auth_bloc.dart';
import 'package:supos_v3/utils/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback onToggle;

  SignupScreen({super.key, required this.onToggle});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppStrings.register, style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(labelText: AppStrings.email),
              controller: emailController,
              validator: FormValidators.validateEmail,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: AppStrings.password),
              obscureText: true,
              controller: passwordController,
              validator: FormValidators.validatePassword,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: AppStrings.confirmPassword),
              obscureText: true,
              controller: confirmPasswordController,
              validator: (value) => FormValidators.validateConfirmPassword(
                  value, passwordController.text),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Form is valid, submit data
                  context.read<AuthBloc>().add(
                        SignupRequested(
                            emailController.text, passwordController.text),
                      );
                }
              },
              child: const Text(AppStrings.register),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.onToggle,
              child: const Text(AppStrings.iHaveAnAccount),
            ),
          ],
        ),
      ),
    );
  }
}
