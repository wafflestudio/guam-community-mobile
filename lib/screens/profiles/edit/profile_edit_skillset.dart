import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import '../../../commons/next.dart';
import '../profile/profile_skillset.dart';

class ProfileEditSkillSet extends StatelessWidget {
  final List<String> dummySkillset = ["figma","photoshop","illustrator",
    "adobe xd","primere pro","aftereffect","cinema4D", "zeplin", "sketch"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProfileEditLabel('기술 스택'),
            Next(onPressed: null),
          ],
        ),
        if (dummySkillset.isNotEmpty)
          Padding(padding: EdgeInsets.only(bottom: 8)),
        ProfileSkillSet(dummySkillset)
      ],
    );
  }
}
