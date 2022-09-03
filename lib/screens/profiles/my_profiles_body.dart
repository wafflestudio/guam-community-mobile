import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_edit_button.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_bottom_buttons.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_img.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_intro.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_nickname.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_interests.dart';
import 'package:guam_community_client/screens/profiles/profile/profile_web_buttons.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';

class MyProfilesBody extends StatelessWidget {
  MyProfilesBody();

  @override
  Widget build(BuildContext context) {
    final Profile me = context.read<Authenticate>().me;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, 40, 24, 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileImg(profileImg: me.profileImg, height: 144, width: 144),
          ProfileNickname(me.nickname),
          ProfileEditButton(),
          ProfileIntro(me.intro),
          ProfileWebButtons(githubId: me.githubId, blogUrl: me.blogUrl),
          ProfileInterests(me.interests),
          ProfileBottomButtons(),
        ],
      ),
    );
  }
}
