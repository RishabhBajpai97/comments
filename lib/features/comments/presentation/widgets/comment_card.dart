import 'package:comments/core/theme/colors.dart';
import 'package:comments/core/utils/format_email.dart';
import 'package:comments/features/comments/domain/entities/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentCard extends StatelessWidget {
  final Comment item;
  final bool displayFullEmail;
  const CommentCard({super.key, required this.item, required this.displayFullEmail});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white70,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.gradient1,
              child: Text(
                item.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Name: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "${item.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Email: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                        children: [
                          TextSpan(
                              text: formatEmail(
                                item.email,
                                displayFullEmail,
                              ),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal))
                        ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    item.body
                        .replaceAll(RegExp(r'\s+'), ' ')
                        .trim(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
