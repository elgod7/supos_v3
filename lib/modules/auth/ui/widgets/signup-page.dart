import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../../logic/auth_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')));
        return;
      }

      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FTextField.email(
              controller: _emailController,
              hint: 'janedoe@foruslabs.com',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => (value?.contains('@') ?? false)
                  ? null
                  : 'Please enter a valid email.',
            ),
            const SizedBox(height: 10),
            FTextField.password(
              controller: _passwordController,
              hint: 'Create password',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => 8 <= (value?.length ?? 0)
                  ? null
                  : 'Password must be at least 8 characters long.',
            ),
            const SizedBox(height: 10),
            FTextField.password(
              controller: _confirmPasswordController,
              hint: 'Confirm password',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value?.isNotEmpty ?? false
                  ? null
                  : 'Please confirm your password',
            ),
            const SizedBox(height: 20),
            FButton(
              label: const Text('Sign Up'),
              onPress: _onSignUpPressed,
            ),
          ],
        ),
      ),
    );
  }
}
