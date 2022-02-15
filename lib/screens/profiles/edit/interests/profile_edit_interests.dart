import 'package:flutter/material.dart';
import '../profile_edit_label.dart';
import '../../../../commons/next.dart';
import '../../profile/profile_interests.dart';
import 'profile_edit_interests_detail.dart';
import '../../../../models/profiles/interest.dart';

class ProfileEditInterests extends StatelessWidget {
  final List<Interest> dummyInterests = [
    new Interest(name: 'figma'),
    new Interest(name: 'photoshop'),
    new Interest(name: 'illustrator'),
    new Interest(name: 'adobe xd'),
    new Interest(name: 'primere pro'),
    new Interest(name: 'aftereffect'),
    new Interest(name: 'cinema4D'),
    new Interest(name: 'zeplin'),
    new Interest(name: 'sketch'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileEditLabel('관심사'),
            Next(onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProfileEditInterestsDetail()
              )
            )),
          ],
        ),
        if (dummyInterests.isNotEmpty)
          Padding(padding: EdgeInsets.only(bottom: 8)),
        ProfileInterests(dummyInterests)
      ],
    );
  }
}
