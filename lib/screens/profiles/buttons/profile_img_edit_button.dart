import 'package:flutter/material.dart';
import '../../../commons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class ProfileImgEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonTextButton(
      text: '프로필 사진 변경',
      fontSize: 12,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      textColor: GuamColorFamily.purpleCore,
      onPressed: () {},
    );
  }
}
