import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/failure.dart';
import 'package:house_chores/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email, required String password});
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password});
}
