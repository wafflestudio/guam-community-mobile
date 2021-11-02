import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/messages/message.dart';

import '../../commons/custom_app_bar.dart';
import 'profiles_body.dart';

class ProfilesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '프로필',
        trailing: Message(),
      ),
    body: ProfilesBody()
    );
  }
}
