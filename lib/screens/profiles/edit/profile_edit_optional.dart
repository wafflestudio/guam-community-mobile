import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'profile_edit_github.dart';
import 'profile_edit_blog.dart';
import 'profile_edit_skillset.dart';

class ProfileEditOptional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileEditLabel(
          '선택사항',
          textColor: GuamColorFamily.purpleCore,
        ),
        Padding(padding: EdgeInsets.only(bottom: 8)),
        ProfileEditGithub(),
        ProfileEditBlog(),
        ProfileEditSkillSet()
      ],
    );
  }
}
