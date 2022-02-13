import 'package:flutter/material.dart';
import '../buttons/web_button.dart';

class ProfileWebButtons extends StatelessWidget {
  final String githubId;
  final String blogUrl;
  final bool isMe;
  static const String githubUrl = 'https://github.com/';

  ProfileWebButtons({this.githubId, this.blogUrl, this.isMe=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 0, isMe ? 24 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          if (githubId != "")
            WebButton(githubUrl+githubId, 'assets/icons/github.svg'),
          if (blogUrl != "")
            WebButton(blogUrl, 'assets/icons/blog.svg'),
        ],
      ),
    );
  }
}
