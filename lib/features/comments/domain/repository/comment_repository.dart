import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, List<Comment>>> getComments();
  Future<Either<Failure, dynamic>> fetchRemoteConfig();
}
