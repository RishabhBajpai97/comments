import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, LoginParams> {
  AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.login(
        email: params.email,  password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams(
      { required this.email, required this.password});
}
