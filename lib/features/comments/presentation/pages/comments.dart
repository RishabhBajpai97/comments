import 'package:comments/core/shared/widgets/drawer.dart';
import 'package:comments/core/shared/widgets/loader.dart';
import 'package:comments/features/comments/presentation/provider/comments_provider.dart';
import 'package:comments/features/comments/presentation/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CommentsProvider>(context, listen: false)
          .getCommentss(context);
      Provider.of<CommentsProvider>(context, listen: false)
          .fetchRemoteConfig(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Consumer<CommentsProvider>(
            builder: (context, commentsProvider, child) {
          return commentsProvider.commentsLoading ||
                  commentsProvider.comments.isEmpty
              ? const Loader()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CommentCard(
                        item: commentsProvider.comments[index],
                        displayFullEmail: commentsProvider.display_full_email,
                      );
                    },
                  ),
                );
        }),
      ),
    );
  }
}
