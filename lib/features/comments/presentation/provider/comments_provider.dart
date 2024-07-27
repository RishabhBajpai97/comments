import 'package:comments/core/shared/usecase.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:comments/features/comments/domain/usecase/fetch_remote_config.dart';
import 'package:comments/features/comments/domain/usecase/get_comments.dart';
import 'package:flutter/material.dart';

class CommentsProvider with ChangeNotifier {
  final GetCommets getComments;
  final FetchRemoteConfig fetchrc;
  CommentsProvider(this.getComments, this.fetchrc);
  bool commentsLoading = false;
  bool display_full_email = true;
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  Future<void> getCommentss(BuildContext context) async {
    commentsLoading = true;
    notifyListeners();
    final res = await getComments(NoParams());
    res.fold((l) {
      showSnackbar(context, l.message);
    }, (cmnts) {
      _comments = cmnts;
    });
    commentsLoading = false;
    notifyListeners();
  }

  Future<void> fetchRemoteConfig(BuildContext context) async {
    final res = await fetchrc(NoParams());
    res.fold((l) {
      showSnackbar(context, l.message);
    }, (value) {
      display_full_email = value;
      notifyListeners();
    });
  }
}
