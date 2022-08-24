import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostPreviewContent extends StatelessWidget {
  final String content;

  PostPreviewContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: 20.8/13,
        fontSize: 13,
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        color: GuamColorFamily.grayscaleGray3,
      ),
    );
  }
}
