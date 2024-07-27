import 'package:comments/core/errors/exception.dart';
import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepository {
  AuthRemoteDatasourceImpl authRemoteDatasourceImpl;
  AuthRepoImpl(this.authRemoteDatasourceImpl);

  @override
  Future<Either<Failure, User>> signup(
      {String? name, String? email, String? password}) async {
    try {
      final response = await authRemoteDatasourceImpl.signup(
          email: email, name: name, password: password);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await authRemoteDatasourceImpl.login(
          email: email, password: password);
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDatasourceImpl.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, User?>> getCurrentUser() async{
    try {
      final user = await authRemoteDatasourceImpl.getCurrentUser();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
