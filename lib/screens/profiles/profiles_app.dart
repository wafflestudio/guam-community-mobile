import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/screens/profiles/other_profiles_body.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import 'my_profiles_body.dart';

class ProfilesApp extends StatelessWidget {
  final int? userId;

  ProfilesApp({this.userId});

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Messages(authProvider)),
        ChangeNotifierProvider(create: (_) => Posts(authProvider)),
      ],
      child: ProfilesAppScaffold(userId),
    );
  }
}

class ProfilesAppScaffold extends StatefulWidget {
  final int? userId;

  ProfilesAppScaffold(this.userId);

  @override
  State<ProfilesAppScaffold> createState() => _ProfilesAppScaffoldState();
}

class _ProfilesAppScaffoldState extends State<ProfilesAppScaffold> {
  Future<Profile?>? otherProfile;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null)
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
        builder: (_, AsyncSnapshot<Profile?> snapshot) {
          // FutureBuilder에서 받아오는 otherProfile 존재 여부에 따라 위젯 변경
          if (snapshot.hasData){
            return Scaffold(
              backgroundColor: GuamColorFamily.grayscaleWhite,
              appBar: CustomAppBar(
                title: '프로필',
                leading: Back(),
              ),
              body: SingleChildScrollView(
                child: OtherProfilesBody(profile: snapshot.data)
              ),
            );
          } else if (snapshot.hasError) {
            // 에러 메시지 띄워주기
            return Center(child: guamProgressIndicator());
          } else {
            return Container(
              color: GuamColorFamily.grayscaleWhite,
              child: Center(
                child: CircularProgressIndicator(
                  color: GuamColorFamily.purpleCore,
                ),
              ),
            );
          }
        }
      );
    } else {
      // 특정 유저 id를 받지 않아 프로필 탭으로 이동하는 경우, 즉 내 프로필
      return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          title: '프로필',
          trailing: MessageBox(),
        ),
        body: SingleChildScrollView(child: MyProfilesBody()),
      );
    }
  }
}
