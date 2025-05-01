import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:supos_v3/modules/auth/logic/auth_bloc.dart';
import 'package:supos_v3/modules/auth/ui/pages/auth_page.dart';

import 'app/home_page.dart';
import 'core/services/supabase_service.dart';
import 'database/local_database.dart';
import 'modules/auth/data/datasources/local_auth.dart';
import 'modules/auth/data/datasources/remote_auth.dart';
import 'modules/auth/data/repositories_impl/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseService.initializeSupabase();

  LocalDatabase db = LocalDatabase();
  db.reset();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc(
          authRepository: AuthRepository(
            localAuth: LocalAuth(db: db),
            remoteAuth: RemoteAuth(),
          ),
        )..add(AppStarted()),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => FTheme(
        data: FThemes.zinc.light,
        child: child!,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
