import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/core/usercase/usecase.dart';
import 'package:house_chores/core/entities/user.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    // TODO: implement call
    return await authRepository.loginWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams(this.email, this.password);
}
