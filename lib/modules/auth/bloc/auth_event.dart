part of 'auth_bloc.dart';

/// Base class for all authentication events.
/// All events extend this class to define specific actions.
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event triggered when the user attempts to log in with email and password.
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  /// Constructor that takes [email] and [password] as parameters.
  LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

/// Event triggered when the app starts to check the user's session.
class AppStarted extends AuthEvent {}

/// Event triggered when the user attempts to sign up with email and password.
class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  /// Constructor that takes [email] and [password] as parameters.
  SignupRequested(this.fullName, this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

/// Event triggered when the user requests to log out.
class LogoutRequested extends AuthEvent {}
