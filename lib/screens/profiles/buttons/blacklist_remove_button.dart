import 'package:flutter/material.dart';
import '../../../commons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class BlackListRemoveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonTextButton(
      text: '해제',
      fontSize: 14,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      textColor: GuamColorFamily.grayscaleGray4,
      onPressed: () {},
    );
  }
}
