import 'package:comments/core/errors/exception.dart';
import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/comments/data/datasource/remote_comments_datasource.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/features/comments/domain/repository/comment_repository.dart';
import 'package:fpdart/src/either.dart';

class CommentRepoImpl implements CommentRepository {
  RemoteCommentsDatasource remoteCommentsDatasource;
  CommentRepoImpl(this.remoteCommentsDatasource);
  @override
  Future<Either<Failure, List<Comment>>> getComments() async {
    try {
      final comments = await remoteCommentsDatasource.getComments();
      return right(comments);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, dynamic>> fetchRemoteConfig() async {
    try {
      final value = await remoteCommentsDatasource.fetchRemoteConfig();
      return right(value);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
