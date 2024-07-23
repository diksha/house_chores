import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_chores/features/auth/domain/entities/user.dart';
import 'package:house_chores/features/auth/domain/usecases/user_login.dart';
import 'package:house_chores/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final response =
          await _userSignUp(UserSignUpParams(event.email, event.password));
      response.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final response =
          await _userLogin(UserLoginParams(event.email, event.password));
      response.fold(
          (l) => emit(AuthFailure(l.message)), (r) => emit(AuthSuccess(r)));
    });
  }
}
