import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostPreviewBoardType extends StatelessWidget {
  final String boardType;

  PostPreviewBoardType(this.boardType);

  @override
  Widget build(BuildContext context) {
    return Text(
      boardType,
      style: TextStyle(
        fontSize: 12,
        height: 19.2/12,
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        color: GuamColorFamily.grayscaleGray4,
      ),
    );
  }
}
