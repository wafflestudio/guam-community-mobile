import 'package:flutter/material.dart';
import 'profile_edit_label.dart';
import 'profile_edit_textfield.dart';

class ProfileEditBlog extends StatelessWidget {
  final String blogUrl;

  ProfileEditBlog(this.blogUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileEditLabel('블로그'),
          ProfileEditTextField(input: blogUrl, isBlogUrl: true)
        ],
      ),
    );
  }
}
