import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supos_v3/core/supabase/supabase_service.dart';
import 'app/app.dart';
import 'modules/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseService.initializeSupabase();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) =>
            AuthBloc()..add(AppStarted())), // Provide AuthBloc globally
  ], child: MyApp()));
}
