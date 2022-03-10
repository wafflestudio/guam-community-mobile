import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'profile_edit_textfield.dart';

class ProfileEditGithub extends StatelessWidget {
  final String githubId;

  ProfileEditGithub(this.githubId);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileEditLabel('github ID'),
          ProfileEditTextField(input: githubId)
        ],
      ),
    );
  }
}
