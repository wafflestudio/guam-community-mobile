import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'profile_edit_textfield.dart';

class ProfileEditBlog extends StatelessWidget {
  final String blogUrl;
  final Function setInput;

  ProfileEditBlog(this.blogUrl, this.setInput);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileEditLabel('블로그'),
          ProfileEditTextField(input: blogUrl, isBlogUrl: true, func: setInput, funcKey: 'blogUrl')
        ],
      ),
    );
  }
}
