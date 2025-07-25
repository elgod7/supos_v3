import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../modules/auth/bloc/auth_bloc.dart';
import '../modules/shops/view/shop_page.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              context.go('/'); // Redirect to login screen when logged out
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return Center(
                    child: Text('Welcome ${state.fullName}'),
                  );
                }
                return Center(
                  child: Text('Welcome'),
                );
              }),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopPage()),
                    );
                  },
                  child: Text("Shops"))
            ],
          ),
        ));
  }
}
