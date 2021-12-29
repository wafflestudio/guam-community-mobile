import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
class InterestChip extends StatelessWidget {
  final String interest;

  InterestChip(this.interest);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('#$interest'),
      labelStyle: TextStyle(
        fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
        fontSize: 14,
        color: GuamColorFamily.purpleLight1,
        height: 22/14,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: GuamColorFamily.purpleLight3,
      // side: BorderSide(color: GuamColorFamily.grayscaleGray6),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    );
  }
}
