import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class InterestButton extends StatelessWidget {
  final String interest;
  final bool deletable;

  InterestButton(this.interest, {this.deletable = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('#$interest'),
      labelStyle: TextStyle(
        fontFamily: deletable ? GuamFontFamily.SpoqaHanSansNeoRegular : GuamFontFamily.SpoqaHanSansNeoMedium,
        fontSize: 14,
        color: deletable ? GuamColorFamily.grayscaleGray2 : GuamColorFamily.purpleLight1,
        height: 22/14,
      ),
      onDeleted: deletable ? () {} : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: GuamColorFamily.purpleLight3,
      side: deletable ? BorderSide(width: 0.5, color: GuamColorFamily.grayscaleGray6) : null,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    );
  }
}
