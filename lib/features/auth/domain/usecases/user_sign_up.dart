import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/core/usercase/usecase.dart';
import 'package:house_chores/core/entities/user.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    // TODO: implement call
    return await authRepository.signUpWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams(this.email, this.password);
}
