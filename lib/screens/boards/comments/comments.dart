import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'comment_banner.dart';
import 'comment_body.dart';

class Comments extends StatelessWidget {
  final Comment comment;
  final bool isAuthor;
  final Function deleteFunc;

  Comments({this.comment, this.isAuthor, this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentBanner(comment, isAuthor, deleteFunc),
        CommentBody(comment),
      ],
    );
  }
}
