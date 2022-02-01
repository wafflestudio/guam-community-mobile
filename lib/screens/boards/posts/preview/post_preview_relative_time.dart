import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostPreviewRelativeTime extends StatelessWidget {
  final DateTime t;

  PostPreviewRelativeTime(this.t);

  @override
  Widget build(BuildContext context) {
    /**
     * TODO: format relative using dayjs (or moment js)
     * s / m / h / d / mth/ y
     */
    return Text(
      (DateTime.now().minute - t.minute).toString() + "분 전",
      style: TextStyle(
      fontSize: 10,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      color: GuamColorFamily.grayscaleGray4,
      )
    );
  }
}
