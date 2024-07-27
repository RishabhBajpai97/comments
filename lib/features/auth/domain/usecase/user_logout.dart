import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements Usecase<void, NoParams> {
  AuthRepository authRepository;
  UserLogout(this.authRepository);
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
