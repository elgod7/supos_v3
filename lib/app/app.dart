import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supos_v3/app/home.dart';
import 'package:supos_v3/utils/constants/app_colors.dart';
import '../core/supabase/auth_service.dart';
import '../modules/auth/view/auth_page.dart';
import '../modules/auth/bloc/auth_bloc.dart';
import '../modules/auth/view/auth_screen/signin_screen.dart';
import '../modules/auth/view/auth_screen/signup_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  bool _sessionChecked = false;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _initializeRouter();
    _checkSession();
  }

  void _initializeRouter() {
    _router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final isLoggingIn = state.uri.toString() == '/';
        final isLoggedIn = context.read<AuthBloc>().state is AuthAuthenticated;
        if (!isLoggedIn && !isLoggingIn) return '/';
        if (isLoggedIn && isLoggingIn) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthPage(key: Key('auth_page')),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(
            userName: 'Elias',
          ),
        ),
      ],
    );
  }

  Future<void> _checkSession() async {
    bool isLoggedIn;
    try {
      isLoggedIn = await _authService.restoreSession();
    } catch (e) {
      debugPrint('Session restoration error: $e');
      isLoggedIn = false;
    }

    if (mounted) {
      setState(() {
        _sessionChecked = true;
        if (isLoggedIn) {
          context.read<AuthBloc>().add(AppStarted());
        } else {
          context.read<AuthBloc>().add(LogoutRequested());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_sessionChecked) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
          primarySwatch: AppColors.primarySwatch, fontFamily: 'Roboto'),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              GoRouter.of(context).go('/');
            } else if (state is AuthAuthenticated) {
              GoRouter.of(context).go('/home');
            }
          },
          child: child,
        );
      },
    );
  }
}
