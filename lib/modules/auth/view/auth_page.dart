import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:supos_v3/modules/auth/view/auth_screen/signin_screen.dart';
import 'package:supos_v3/modules/auth/view/auth_screen/signup_screen.dart';
import 'package:supos_v3/utils/constants/app_sizes.dart';
import 'package:supos_v3/utils/shared_components/component_styles.dart';
import 'package:supos_v3/utils/shared_components/animations/loading_page.dart';
import '../bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = false;
  bool showWelcome = true;

  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  void toggleWelcome() {
    setState(() {
      showWelcome = !showWelcome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        }, child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingPage();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppSizes.defaultVerticalSpace,
              Lottie.asset(
                'assets/animation/login_animation.json',
                width: 300,
                height: 300,
                animate: false,
              ),
              //AppSizes.defaultVerticalSpace,
              showWelcome
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: headingTextStyle(),
                          ),
                          AppSizes.defaultVerticalSpace,
                          Text(
                            'Welcome to Supos, the best POS system,\n where you manage your sales',
                            style: subheadingTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          AppSizes.defaultVerticalSpace,
                          AppSizes.defaultVerticalSpace,
                          ElevatedButton(
                            onPressed: () {
                              toggleWelcome();
                              showLogin = true;
                            },
                            style: primaryButtonStyle(context, false),
                            child: const Text('Login'),
                          ),
                          AppSizes.defaultVerticalSpace,
                          ElevatedButton(
                            onPressed: () {
                              toggleWelcome();
                              showLogin = false;
                            },
                            style: secondaryButtonStyle(context, false),
                            child: const Text('Sign Up'),
                          ),
                          AppSizes.defaultVerticalSpace,
                          AppSizes.defaultVerticalSpace,
                          Text(
                            'Sign up Using',
                            style: normalTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/icons/google.png',
                                      width: 25)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/icons/facebook.png',
                                      width: 25)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset('assets/icons/apple.png',
                                      width: 25)),
                            ],
                          )
                        ],
                      ),
                    )
                  : showLogin
                      ? SigninScreen(
                          onToggle: toggleScreens, onWelcome: toggleWelcome)
                      : SignupScreen(
                          onToggle: toggleScreens,
                          onWelcome: toggleWelcome,
                        ),
            ],
          );
        })),
      ),
    );
  }
}
