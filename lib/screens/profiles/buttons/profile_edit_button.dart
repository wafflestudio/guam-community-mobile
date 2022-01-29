import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../pages/profiles_edit.dart';

class ProfileEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProfile = context.read<MyProfile>().myProfile;

    return IconText(
      iconSize: 18,
      iconPath: 'assets/icons/write.svg',
      iconColor: GuamColorFamily.purpleLight1,
      paddingBtw: 0,
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ProfilesEdit(myProfile)
          )
      ),
    );
  }
}
