import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/auth/domain/entities/user.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUser implements Usecase<User?, NoParams> {
  AuthRepository authRepository;
  GetCurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await authRepository.getCurrentUser();
  }
}
