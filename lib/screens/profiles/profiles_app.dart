import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Messages()),
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
  Profile myProfile;
  Future<Profile> otherProfile;

  @override
  void initState() {
    super.initState();
    myProfile = context.read<Authenticate>().me;
    otherProfile = Future.delayed(
      Duration.zero,
      () async => context.read<Authenticate>().getUserProfile(widget.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 특정 userId를 받아 otherProfile 위젯 호출하는 경우.
    if (widget.userId != null){
      return FutureBuilder(
        future: otherProfile,
        builder: (_, AsyncSnapshot<Profile> snapshot) {
          // FutureBuilder에서 받아오는 otherProfile 존재 여부에 따라 위젯 변경
          if (snapshot.hasData){
            return Scaffold(
              backgroundColor: GuamColorFamily.grayscaleWhite,
              appBar: CustomAppBar(
                title: snapshot.data.nickname,
                leading: Back(),
              ),
              body: SingleChildScrollView(
                child: OtherProfilesBody(profile: snapshot.data)
              ),
            );
          } else if (snapshot.hasError) {
            // 에러 메시지 띄워주기
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        }
      );
    } else {
      // 특정 유저 id를 받지 않아 프로필 탭으로 이동하는 경우
      return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          title: '프로필',
          trailing: MessageBox(),
        ),
        body: SingleChildScrollView(child: MyProfilesBody(myProfile)),
      );
    }
  }
}
