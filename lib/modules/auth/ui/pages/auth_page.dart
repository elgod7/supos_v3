import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:supos_v3/modules/auth/logic/auth_bloc.dart';

import '../widgets/login_page.dart';
import '../widgets/signup-page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;

  void _toggleLogin() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      content: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthError) {
          FAlert(
            title: Text('Error'),
            subtitle: Text(state.message),
            style: FAlertStyle.destructive,
          );
        } else if (state is AuthAuthenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FHeader(
              title: _isLogin ? Text('Login') : Text('Sign Up'),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: FAlert(
            //     title:
            //         _isLogin ? Text('Welcome Back!') : Text('Create an Account'),
            //     subtitle: _isLogin
            //         ? Text('Please enter your credentials to continue.')
            //         : Text('Please fill in the details to create an account.'),
            //   ),
            // ),
            const SizedBox(height: 20),
            _isLogin ? const LoginForm() : const SignUpForm(),
            const SizedBox(height: 20),
            FButton(
              onPress: _toggleLogin,
              label: _isLogin
                  ? Text('Don\'t have an account? Sign Up')
                  : const Text('Already have an account? Log in'),
              style: FButtonStyle.ghost,
            ),
          ],
        );
      }),
      contentPad: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
