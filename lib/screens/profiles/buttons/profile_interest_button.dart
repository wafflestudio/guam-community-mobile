import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../../models/profiles/interest.dart';

class ProfileInterestButton extends StatelessWidget {
  final Interest interest;
  final bool deletable;

  ProfileInterestButton(this.interest, {this.deletable = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(interest.name),
      labelStyle: TextStyle(
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        fontSize: 12,
        color: deletable ? GuamColorFamily.grayscaleGray2 : GuamColorFamily.grayscaleGray4,
        height: 19.2/12,
      ),
      onDeleted: deletable ? () {} : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: GuamColorFamily.grayscaleWhite,
      side: BorderSide(color: GuamColorFamily.grayscaleGray6),
      padding: EdgeInsets.all(4),
    );
  }
}
