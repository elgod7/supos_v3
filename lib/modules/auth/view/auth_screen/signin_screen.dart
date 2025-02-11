import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/utils/constants/app_strings.dart';
import 'package:supos_v3/utils/helpers/form_validators.dart.dart';

import '../../bloc/auth_bloc.dart';

class SigninScreen extends StatefulWidget {
  final VoidCallback onToggle;

  const SigninScreen({super.key, required this.onToggle});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppStrings.login, style: TextStyle(fontSize: 24)),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Form is valid, submit data
                  context.read<AuthBloc>().add(LoginRequested(
                      emailController.text, passwordController.text));
                }
              },
              child: const Text(AppStrings.login),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.onToggle,
              child: const Text(AppStrings.doNotHaveAnAccount),
            ),
          ],
        ),
      ),
    );
  }
}
