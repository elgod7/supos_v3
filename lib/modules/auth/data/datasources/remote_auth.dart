import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAuth {
  final SupabaseClient _supabase = Supabase.instance.client;

  RemoteAuth();

  Future<User?> signIn(
      {required String email, required String password}) async {
    final response = await _supabase.auth
        .signInWithPassword(email: email, password: password);
    return response.user;
  }

  Future<User?> signUp(
      {required String email, required String password}) async {
    final response =
        await _supabase.auth.signUp(email: email, password: password);
    final session = _supabase.auth.currentSession;
    return response.user;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
  Session? getCurrentSession() {
    return _supabase.auth.currentSession;
  }
}
