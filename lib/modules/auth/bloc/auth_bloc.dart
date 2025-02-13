import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '/core/supabase/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Bloc that manages the authentication flow.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  /// Constructor that initializes the bloc with the [AuthInitial] state.
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading());
      try {
        final isLoggedIn = await _authService.restoreSession();
        final authUserId = _authService.currentUserId.toString();
        if (isLoggedIn) {
          final fullName = await _authService.getUserFullName(authUserId);
          emit(AuthAuthenticated(fullName));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError('Failed to restore session: ${e.toString()}'));
      }
    });

    /// Event handler for [LoginRequested].
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Attempt to log in with the provided email and password.
        await _authService.signIn(event.email, event.password);
        final fullName = await _authService.getUserFullName(_authService.currentUserId);
        emit(AuthAuthenticated(fullName));
      } catch (e) {
        // Emit [AuthError] if an exception occurs.
        emit(AuthError(e.toString()));
      }
    });

    /// Event handler for [SignupRequested].
    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // Attempt to sign up with the provided email and password.
        // Sign up the user with Supabase auth
        final response = await _authService.signUp(event.email, event.password);

        if (response.user != null) {
          // Insert the full name into the 'users' table
          await _authService.addUserProfile(response.user!.id, event.fullName);
          final fullName =
              await _authService.getUserFullName(response.user!.id);

          emit(AuthAuthenticated(
              fullName)); // Pass the full name to the Authenticated state
        }
      } catch (e) {
        // Emit [AuthError] if an exception occurs.
        emit(AuthError('Signup failed: $e'));
      }
    });

    /// Event handler for [LogoutRequested].
    on<LogoutRequested>((event, emit) async {
      try {
        // Attempt to log out the current user.
        await _authService.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        // Emit [AuthError] if an exception occurs during logout.
        emit(AuthError('Failed to log out: ${e.toString()}'));
      }
    });
  }
}
