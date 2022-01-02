import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';

import '../../commons/custom_app_bar.dart';
import 'profiles_body.dart';

class ProfilesApp extends StatelessWidget {
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
