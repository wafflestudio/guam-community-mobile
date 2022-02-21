import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class ProfileIntro extends StatelessWidget {
  final String intro;

  ProfileIntro(this.intro);

  @override
  Widget build(BuildContext context) {
    return Text(
      intro ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
          fontSize: 14,
          color: GuamColorFamily.grayscaleGray3,
          height: 22.4/14
      ),
    );
  }
}