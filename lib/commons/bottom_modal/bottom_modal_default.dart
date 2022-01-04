import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class BottomModalDefault extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BottomModalDefault({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: GuamColorFamily.grayscaleGray1,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
          ),
        ),
      )
    );
  }
}
