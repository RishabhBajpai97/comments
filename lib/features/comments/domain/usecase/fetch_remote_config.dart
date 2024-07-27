import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/comments/domain/repository/comment_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchRemoteConfig implements Usecase<dynamic, NoParams> {
  CommentRepository commentRepository;
  FetchRemoteConfig(this.commentRepository);
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    return await commentRepository.fetchRemoteConfig();
  }
}
