import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import 'profiles_body.dart';

class ProfilesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProfile(authToken: context.read<Authenticate>().authToken)),
      ],
      child: ProfilesAppScaffold(),
    );
  }
}

class ProfilesAppScaffold extends StatefulWidget {
  @override
  State<ProfilesAppScaffold> createState() => _ProfilesAppScaffoldState();
}

class _ProfilesAppScaffoldState extends State<ProfilesAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '프로필',
        trailing: MessageBox(),
      ),
      body: SingleChildScrollView(
        child: ProfilesBody(),
      )
    );
  }
}
