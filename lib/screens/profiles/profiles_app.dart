import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/screens/profiles/other_profiles_body.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import 'my_profiles_body.dart';

class ProfilesApp extends StatelessWidget {
  final int userId;

  ProfilesApp({this.userId});

  @override
  Widget build(BuildContext context) {
    String authToken = context.read<Authenticate>().authToken;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProfile(authToken: authToken)),
        ChangeNotifierProvider(create: (_) => OtherProfile(userId: userId)),
        ChangeNotifierProvider(create: (_) => Messages(authToken: authToken)),
      ],
      child: ProfilesAppScaffold(userId),
    );
  }
}

class ProfilesAppScaffold extends StatefulWidget {
  final int userId;

  ProfilesAppScaffold(this.userId);

  @override
  State<ProfilesAppScaffold> createState() => _ProfilesAppScaffoldState();
}

class _ProfilesAppScaffoldState extends State<ProfilesAppScaffold> {
  Future<Profile> otherProfile;

  @override
  void initState() {
    super.initState();
    otherProfile = context.read<OtherProfile>().getUserProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final myProfile = context.read<MyProfile>().myProfile;

    return FutureBuilder(
      future: otherProfile,
      builder: (_, snapshot) {
        // FutureBuilder에서 받아오는 otherProfile이 null이면 내 프로필 탭
        if (snapshot.hasData){
          return Scaffold(
            backgroundColor: GuamColorFamily.grayscaleWhite,
            appBar: CustomAppBar(
              title: snapshot.data.nickname,
              leading: Back(),
            ),
            body: SingleChildScrollView(
              child: OtherProfilesBody(snapshot.data),
            ),
          );
        } else {
          return Scaffold(
              backgroundColor: GuamColorFamily.grayscaleWhite,
              appBar: CustomAppBar(
                title: '프로필',
                trailing: MessageBox(),
              ),
              body: SingleChildScrollView(child: MyProfilesBody(myProfile))
          );
        }
      }
    );
  }
}
