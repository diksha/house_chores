import 'package:fpdart/fpdart.dart';
import 'package:house_chores/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String email, required String password});
  Future<Either<Failure, String>> loginWithEmailPassword(
      {required String email, required String password});
}
