import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'comment_banner.dart';
import 'comment_body.dart';

class Comments extends StatelessWidget {
  final Comment comment;
  final bool isAuthor;

  Comments({this.comment, this.isAuthor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentBanner(comment, isAuthor),
        CommentBody(comment),
      ],
    );
  }
}
