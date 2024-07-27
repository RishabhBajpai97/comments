import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signup(
      {String name, String email, String password});
  Future<Either<Failure, User>> login(
      {required String email, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
}
