part of 'auth_bloc.dart';

/// Base class for all authentication states.
/// All states extend this class to represent different stages in authentication.
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initial state before any authentication action has taken place.
class AuthInitial extends AuthState {}

/// State while authentication (login/signup) is in progress.
class AuthLoading extends AuthState {}

/// State when the user is successfully authenticated (logged in).
class AuthAuthenticated extends AuthState {
  final String fullName;

  /// Constructor that takes the user's [fullName] as a parameter.
  AuthAuthenticated(this.fullName);

  @override
  List<Object> get props => [fullName];
}

/// State when the user is not authenticated (logged out or session expired).
class AuthUnauthenticated extends AuthState {}

/// State when an error occurs during authentication.
class AuthError extends AuthState {
  final String message;

  /// Constructor that takes an error [message] as a parameter.
  AuthError(this.message);

  @override
  List<Object> get props => [message];
}
