import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_chores/features/auth/domain/usercases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final response =  await _userSignUp(UserSignUpParams(event.email, event.password));
      response.fold((l)=> emit(AuthFailure(l.message)), (r)=>emit(AuthSuccess(r)));
    });
  }
}
