import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class ProfileSkillButton extends StatelessWidget {
  final String skill;
  final bool deletable;

  ProfileSkillButton(this.skill, {this.deletable = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill),
      labelStyle: TextStyle(
        fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        fontSize: 12,
        color: GuamColorFamily.grayscaleGray4,
        height: 19.2/12,
      ),
      onDeleted: deletable ? () {} : null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: Colors.transparent,
      side: BorderSide(color: GuamColorFamily.grayscaleGray6),
      padding: EdgeInsets.all(4),
    );
  }

}