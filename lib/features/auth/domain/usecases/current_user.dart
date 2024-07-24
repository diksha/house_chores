import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/core/usercase/usecase.dart';
import 'package:house_chores/core/entities/user.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    // TODO: implement call
    return await authRepository.currentUser();
  }
}
