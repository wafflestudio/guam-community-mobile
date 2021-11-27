import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../commons/custom_app_bar.dart';
import '../../commons/common_text_button.dart';

class ProfilesEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '프로필 수정',
          trailing: CommonTextButton(
            text: '완료',
            fontSize: 16,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
            textColor: GuamColorFamily.purpleCore,
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          // child: ProfilesBody(),
        )
    );
  }
}
