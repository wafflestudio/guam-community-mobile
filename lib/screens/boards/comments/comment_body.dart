import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class CommentBody extends StatelessWidget {
  final Comment comment;

  CommentBody(this.comment);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32, top: 3, right: 12),
          child: Text(
            comment.comment,
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32, top: 4, bottom: 8),
          child: IconText(
            iconSize: 18,
            fontSize: 10,
            text: comment.like.toString(),
            iconPath: comment.isLiked
                ? 'assets/icons/like_filled.svg'
                : 'assets/icons/like_outlined.svg',
            onPressed: (){},
            iconColor: comment.isLiked
                ? GuamColorFamily.redCore
                : GuamColorFamily.grayscaleGray5,
            textColor: GuamColorFamily.grayscaleGray5,
          ),
        ),
      ],
    );
  }
}
