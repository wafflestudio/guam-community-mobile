import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/profiles/buttons/profile_skill_button.dart';
import 'package:guam_community_client/screens/profiles/edit/skillset/profile_edit_skillset_label.dart';
import 'package:guam_community_client/screens/profiles/edit/skillset/profile_edit_skillset_textfield.dart';
import '../../../../commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/back.dart';

class ProfileEditSkillSetDetail extends StatelessWidget {
  final List<dynamic> skillSet = ["figma","photoshop","illustrator","adobe xd",
    "primere pro","aftereffect","cinema4D", "zeplin", "sketch"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '프로필 수정',
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileEditSkillSetLabel(skillSet.length),
                ProfileEditSkillSetTextField(),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 5,
                  children: [...skillSet.map((skill) => ProfileSkillButton(skill))],
                )
              ],
            ),
          ),
        )
    );
  }
}
