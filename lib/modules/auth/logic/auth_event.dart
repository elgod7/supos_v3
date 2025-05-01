part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignInRequested({required this.email, required this.password});
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  AuthSignUpRequested({required this.email, required this.password});
}

class AuthSignOutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AppStarted extends AuthEvent {
  final String? accessToken;

  AppStarted({this.accessToken});
}
