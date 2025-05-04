import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  late final SupabaseClient _client;

  factory SupabaseService() => _instance;

  SupabaseService._internal() {
    _client = Supabase.instance.client;  // Get the client after initialization
  }

  /// Returns the SupabaseClient
  SupabaseClient getClient() {
    return _client;
  }

  /// Initializes Supabase (call this once during app startup)
  static Future<void> initializeSupabase() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  }
}