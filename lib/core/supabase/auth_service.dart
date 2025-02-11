import 'supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = SupabaseService().getClient();

  /// Check if the user is currently logged in
  bool isLoggedIn() {
    return _supabase.auth.currentSession != null;
  }

  /// Restore the session if it exists. Returns `true` if successful, otherwise `false`.
  Future<bool> restoreSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session != null) {
        print('Session restored successfully');
        return true;
      }
      print('No session found');
      return false;
    } catch (e) {
      print('Error restoring session: $e');
      return false;
    }
  }

  /// Log in with email and password
  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabase.auth
          .signInWithPassword(email: email, password: password);
      if (response.session == null) {
        throw Exception('Login failed. Please check your credentials.');
      }
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  /// Sign up with email and password
  Future<void> signUp(String email, String password) async {
    try {
      final response =
          await _supabase.auth.signUp(email: email, password: password);
      if (response.user == null) {
        throw Exception('Signup failed. Please try again.');
      }
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  /// Listen for authentication state changes
  Stream<bool> onAuthStateChanged() {
    return _supabase.auth.onAuthStateChange.map((event) {
      return event.event == AuthChangeEvent.signedIn;
    });
  }
}
