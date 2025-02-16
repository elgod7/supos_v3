import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supos_v3/modules/shops/view/shop_page.dart';
import '../app/home.dart';
import '../modules/auth/bloc/auth_bloc.dart';
import '../modules/auth/view/auth_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();

    final GoRouter _router = GoRouter(
      refreshListenable: GoRouterRefreshStream(
          authBloc.stream), // Auto-refresh GoRouter when Bloc state changes
      initialLocation: '/',
      redirect: (context, state) {
        final isAuthenticated = authBloc.state is AuthAuthenticated;
        final isLoggingIn = state.matchedLocation == '/';
        if (!isAuthenticated) {
          return isLoggingIn
              ? null
              : '/'; // Redirect to login if not authenticated
        }
        if (isAuthenticated && isLoggingIn) return '/home';
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const AuthPage()),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(userName: 'Elias'),
        ),
        GoRoute(path: '/shop', builder: (context, state) => const ShopPage()),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshStream(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
