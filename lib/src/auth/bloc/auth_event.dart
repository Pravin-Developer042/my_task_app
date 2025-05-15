part of 'auth_bloc.dart';

abstract class AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class LoginRequest extends AuthEvent {}

class LogoutRequest extends AuthEvent {}
