import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_interest_button.dart';
import './profile_edit_interests_label.dart';
import './profile_edit_interests_textfield.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../../../commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../../models/profiles/interest.dart';

class ProfileEditInterestsDetail extends StatelessWidget {
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
    return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          leading: Back(),
          title: '프로필 수정',
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileEditInterestsLabel(dummyInterests.length),
                ProfileEditInterestsTextField(),
                Wrap(
                  // alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 5,
                  children: [...dummyInterests.map((i) => ProfileInterestButton(
                    i,
                    deletable: true,
                  ))],
                )
              ],
            ),
          ),
        )
    );
  }
}
