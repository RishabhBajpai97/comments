// lib/features/comments/data/models/comment_model.dart

import 'package:comments/features/comments/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required super.postId,
    required super.id,
    required super.name,
    required super.email,
    required super.body,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}
