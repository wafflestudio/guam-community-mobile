import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/message_send_button.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_img.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_intro.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_nickname.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_web_buttons.dart';
import 'profile/profile_skillset.dart';

class OtherProfilesBody extends StatelessWidget {
  final Profile otherProfile;

  const OtherProfilesBody(this.otherProfile);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 40, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImg(profileImg: otherProfile.profileImg, height: 144, width: 144),
          ProfileNickname(nickname: otherProfile.nickname, isMine: false),
          ProfileIntro(otherProfile.intro),
          ProfileWebButtons(
            githubId: otherProfile.githubId,
            blogUrl: otherProfile.blogUrl,
            isMine: false,
          ),
          MessageSendButton(otherProfile),
          ProfileSkillSet(otherProfile.skillSet),
        ],
      ),
    );
  }
}
