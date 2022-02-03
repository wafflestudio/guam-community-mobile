import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/message_send_button.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_img.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_intro.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_nickname.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_web_buttons.dart';
import 'profile/profile_skillset.dart';

class OtherProfilesBody extends StatelessWidget {
  final Profile profile;
  final bool isMe;

  const OtherProfilesBody({this.profile, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 40, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImg(profileImg: profile.profileImg, height: 144, width: 144),
          ProfileNickname(nickname: profile.nickname, isMine: false),
          ProfileIntro(profile.intro),
          ProfileWebButtons(
            githubId: profile.githubId,
            blogUrl: profile.blogUrl,
            isMine: false,
          ),
          // 추후 MyProfile의 id랑 비교해서 본인임이 확인되면 프로필 탭으로 이동하도록 하겠습니다.
          if (!isMe) MessageSendButton(profile),
          ProfileSkillSet(profile.skillSet),
        ],
      ),
    );
  }
}
