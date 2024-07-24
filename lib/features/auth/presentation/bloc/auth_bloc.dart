import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_chores/core/common/cubits/cubits/app_user/app_user_cubit.dart';
import 'package:house_chores/core/usercase/usecase.dart';
import 'package:house_chores/core/entities/user.dart';
import 'package:house_chores/features/auth/domain/usecases/current_user.dart';
import 'package:house_chores/features/auth/domain/usecases/user_login.dart';
import 'package:house_chores/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required currentUser,
      required appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>((event, emit) async {
      final response =
          await _userSignUp(UserSignUpParams(event.email, event.password));
      response.fold((l) => emit(AuthFailure(l.message)),
          (r) => _emitAuthSuccess(r, emit));
    });
    on<AuthLogin>((event, emit) async {
      final response =
          await _userLogin(UserLoginParams(event.email, event.password));
      response.fold((l) => emit(AuthFailure(l.message)),
          (r) => _emitAuthSuccess(r, emit));
    });
    on<AuthIsUserLoggedIn>((event, emit) async {
      final response = await _currentUser(NoParams());
      response.fold((l) => emit(AuthFailure(l.message)),
          (r) => _emitAuthSuccess(r, emit));
    });
  }
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
