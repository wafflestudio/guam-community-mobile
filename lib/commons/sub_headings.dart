import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/fonts.dart';

class SubHeadings extends StatelessWidget {
  final String subheading;
  final double fontSize;
  final Color fontColor;
  final String fontFamily;

  SubHeadings(this.subheading, {this.fontSize = 16, this.fontColor = Colors.black, this.fontFamily = GuamFontFamily.SpoqaHanSansNeoRegular});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        subheading,
        style: TextStyle(
          fontSize: fontSize,
          color: fontColor,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
