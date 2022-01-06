import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_img.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_intro.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_nickname.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_web_buttons.dart';
import 'buttons/profile_edit_button.dart';
import 'profile/profile_skillset.dart';
import 'profile/profile_bottom_buttons.dart';

class ProfilesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProfile = context.read<MyProfile>().profile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 40, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImg(profileImg: myProfile.profileImg, height: 144, width: 144),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileNickname(myProfile.nickname),
              ProfileEditButton(),
            ],
          ),
          ProfileIntro(myProfile.intro),
          ProfileWebButtons(githubId: myProfile.githubId, blogUrl: myProfile.blogUrl),
          ProfileSkillSet(myProfile.skillSet),
          ProfileBottomButtons(),
        ],
      ),
    );
  }
}
