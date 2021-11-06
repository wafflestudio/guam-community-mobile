import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'comment_banner.dart';
import 'comment_body.dart';

class Comments extends StatelessWidget {
  final Comment comment;

  Comments({this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentBanner(comment),
        CommentBody(comment),
      ],
    );
  }
}
