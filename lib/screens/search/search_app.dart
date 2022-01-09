import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'search_app_bar.dart';
import 'search_app_textfield.dart';
import '../../commons/common_text_button.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: SearchAppBar(
        title: Wrap(
          direction: Axis.horizontal,
          children: [
            SearchAppTextField(),
            // CommonTextButton(
            //   text: '취소',
            //   fontSize: 14,
            //   fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            //   textColor: GuamColorFamily.purpleCore,
            //   onPressed: () {},
            // )
          ],
        ),
      ),
    );
  }
}
