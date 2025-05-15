import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_task_app/src/auth/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequest>(_login);
    on<CheckAuthStatus>(_checkAuthStatus);
    on<LogoutRequest>(_logout);
  }

  void _login(LoginRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await AuthService.authenticateWithGitHub();
      emit(Authenticated(token));
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  void _checkAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) async {
    try {
      final token = await AuthService.getStoredToken();
      if (token == null) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(token));
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void _logout(LogoutRequest event, Emitter<AuthState> emit) async {
    try {
      await AuthService.logout();
      emit(Unauthenticated());
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
