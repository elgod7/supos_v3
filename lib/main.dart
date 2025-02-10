import 'package:flutter/material.dart';
import 'package:supos_v3/core/supabase/supabase_services.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseService.initializeSupabase();

  runApp(const MyApp());
}

