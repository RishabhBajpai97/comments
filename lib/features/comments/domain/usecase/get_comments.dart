import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/shared/usecase.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/features/comments/domain/repository/comment_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCommets implements Usecase<List<Comment>, NoParams> {
  CommentRepository commentRepository;
  GetCommets(this.commentRepository);
  @override
  Future<Either<Failure, List<Comment>>> call(NoParams params) async {
    return await commentRepository.getComments();
  }
}
