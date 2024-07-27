import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<User, SignupParams> {
  AuthRepository authRepository;
  UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(SignupParams params) async {
    return await authRepository.signup(
        email: params.email, name: params.name, password: params.password);
  }
}

class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams(
      {required this.name, required this.email, required this.password});
}
