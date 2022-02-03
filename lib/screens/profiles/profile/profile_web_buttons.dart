import 'package:flutter/material.dart';
import '../buttons/web_button.dart';

class ProfileWebButtons extends StatelessWidget {
  final String githubId;
  final String blogUrl;
  final bool isMine;
  static const String githubUrl = 'https://github.com/';

  ProfileWebButtons({this.githubId, this.blogUrl, this.isMine=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 0, isMine ? 24 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          WebButton(githubUrl+githubId, 'assets/icons/github.svg'),
          WebButton(blogUrl, 'assets/icons/blog.svg'),
        ],
      ),
    );
  }
}
