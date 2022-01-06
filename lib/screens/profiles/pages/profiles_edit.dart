import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_img_edit_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_text_button.dart';
import '../profile/profile_img.dart';
import '../edit/profile_edit_nickname.dart';
import '../edit/profile_edit_intro.dart';
import '../edit/profile_edit_optional.dart';

class ProfilesEdit extends StatelessWidget {
  final Profile profile;

  ProfilesEdit(this.profile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
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
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileImg(profileImg: profile.profileImg, height: 96, width: 96),
                ProfileImgEditButton(),
                ProfileEditNickname(),
                ProfileEditIntro(),
                ProfileEditOptional(),
              ],
            ),
          ),
        )
    );
  }
}
