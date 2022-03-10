import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'profile_edit_textfield.dart';

class ProfileEditNickname extends StatelessWidget {
  final String nickname;

  ProfileEditNickname(this.nickname);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 24, 0, 44),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileEditLabel('이름'),
          ProfileEditTextField(input: nickname, maxLength: 10)
        ],
      ),
    );
  }
}
