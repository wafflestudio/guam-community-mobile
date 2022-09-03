import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../pages/profiles_edit.dart';

class ProfileEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProfile = context.read<Authenticate>().me;

    return TextButton(
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProfilesEdit(myProfile))),
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Text('프로필 수정', style: TextStyle(color: GuamColorFamily.purpleCore, fontSize: 12)),
    );
  }
}
