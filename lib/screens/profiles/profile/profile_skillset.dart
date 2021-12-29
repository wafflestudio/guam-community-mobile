import 'package:flutter/material.dart';
import '../buttons/profile_skill_button.dart';

class ProfileSkillSet extends StatelessWidget {
  final List<dynamic> skillSet;

  ProfileSkillSet(this.skillSet);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 5,
      children: [...skillSet.map((skill) => ProfileSkillButton(skill))],
    );
  }
}
