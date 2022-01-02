import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_img_edit_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_text_button.dart';
import '../profile/profile_img.dart';
import 'package:guam_community_client/models/picture.dart';
import '../edit/profile_edit_nickname.dart';
import '../edit/profile_edit_intro.dart';
import '../edit/profile_edit_optional.dart';

class ProfilesEdit extends StatelessWidget {
  final Profile dummy = Profile(
    id: 1,
    profileImg: Picture(
      id: 1,
      urlPath: "https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75",
    ),
    nickname: "bluesky",
    intro: "🦋 N년차 프로덕트 디자이너\n🐶 강아지 몽무와 동거 중\n✉️ abcd@abcd.com\n📷 @abcddesign",
    githubId: "abcddesign111",
    blogUrl: "tistory.abcddesign",
    skillSet: ["figma","photoshop","illustrator","adobe xd","primere pro","aftereffect","cinema4D", "zeplin", "sketch"],
  );

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
                ProfileImg(profileImg: dummy.profileImg, height: 96, width: 96),
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
