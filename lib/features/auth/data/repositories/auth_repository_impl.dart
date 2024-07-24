import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/exceptions.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:house_chores/core/entities/user.dart';
import 'package:house_chores/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User is not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
