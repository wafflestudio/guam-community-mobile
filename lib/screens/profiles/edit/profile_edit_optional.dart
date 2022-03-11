import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/profiles/edit/interests/profile_edit_interests.dart';
import 'profile_edit_label.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'profile_edit_github.dart';
import 'profile_edit_blog.dart';
import 'interests/profile_edit_interests.dart';

class ProfileEditOptional extends StatelessWidget {
  final Map<String, dynamic> input;
  final Function setInput;

  ProfileEditOptional(this.input, this.setInput);

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
        ProfileEditGithub(input['githubId'], setInput),
        ProfileEditBlog(input['blogUrl'], setInput),
        ProfileEditInterests(),
      ],
    );
  }
}
