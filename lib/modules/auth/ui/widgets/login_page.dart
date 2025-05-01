import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import '../../logic/auth_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLoginPressed() {
    context.read<AuthBloc>().add(
          AuthSignInRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      Padding(
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => 8 <= (value?.length ?? 0)
                      ? null
                      : 'Password must be at least 8 characters long.',
                ),
                const SizedBox(height: 20),
                FButton(
                  label: const Text('Login'),
                  onPress: () {
                    if (!_formKey.currentState!.validate()) {
                      return; // Form is invalid.
                    }
                    _onLoginPressed();
                    // Form is valid, do something.
                  },
                ),
              ],
            ),
          ),
        );
}
