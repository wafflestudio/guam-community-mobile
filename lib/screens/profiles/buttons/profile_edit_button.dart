import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProfileEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconText(
      iconSize: 18,
      iconPath: 'assets/icons/write.svg',
      iconColor: GuamColorFamily.purpleLight1,
      paddingBtw: 0,
      onPressed: () {},
    );
  }
}