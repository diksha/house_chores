import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/exceptions.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:house_chores/features/auth/domain/entities/user.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final userID = await remoteDataSource.signUpWithEmailPassword(
          email: email, password: password);
      return right(userID);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
