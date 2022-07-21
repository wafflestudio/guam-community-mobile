import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'profile_edit_textfield.dart';

class ProfileEditIntro extends StatelessWidget {
  final String intro;
  final Function setInput;

  ProfileEditIntro(this.intro, this.setInput);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileEditLabel('소개'),
          Padding(padding: EdgeInsets.only(bottom: 16)),
          Row(  // Essential to fit in the whole space
            children: [
              ProfileEditTextField(input: intro, maxLength: 150, func: setInput, funcKey: 'introduction')
            ],
          )
        ],
      ),
    );
  }
}
