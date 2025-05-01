import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import '../modules/auth/logic/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('Settings'),
        actions: [
          FHeaderAction(
            icon: Icon(Icons.logout),
            semanticLabel: 'Logout',
            onPress: () {
              context.read<AuthBloc>().add(AuthSignOutRequested());
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      content: Column(
        children: [
          FCard(
            title: const Text('Notification'),
            subtitle: const Text('You have 3 unread messages.'),
            child: FButton(label: const Text('Read messages'), onPress: () {}),
          ),
        ],
      ),
      footer: FBottomNavigationBar(
        children: [],
      ),
      contentPad: true,
      resizeToAvoidBottomInset: true,
    );
  }
}
