import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/profiles/profile.dart';
import '../../../../providers/user_auth/authenticate.dart';
import '../profile_edit_label.dart';
import '../../../../commons/next.dart';
import '../../profile/profile_interests.dart';
import 'profile_edit_interests_detail.dart';
import '../../../../models/profiles/interest.dart';

class ProfileEditInterests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Interest> interests = context.read<Authenticate>().me.interests;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileEditLabel('관심사'),
            Next(onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProfileEditInterestsDetail(interests)
              )
            )),
          ],
        ),
        if (interests.isNotEmpty)
          Padding(padding: EdgeInsets.only(bottom: 8)),
        ProfileInterests(interests)
      ],
    );
  }
}
