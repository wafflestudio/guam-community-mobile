import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';

class PostPreviewRelativeTime extends StatelessWidget {
  final DateTime t;

  PostPreviewRelativeTime(this.t);

  @override
  Widget build(BuildContext context) {
    /// Render DateTime using 'Jiffy' library
    Jiffy.locale('ko');

    return Text(
      Jiffy(t).fromNow(),
      style: TextStyle(
      fontSize: 10,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      color: GuamColorFamily.grayscaleGray4,
      )
    );
  }
}
