import 'package:flutter/material.dart';
import '../buttons/web_button.dart';

class ProfileWebButtons extends StatelessWidget {
  final String githubId;
  final String blogUrl;

  ProfileWebButtons({this.githubId, this.blogUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 5, 0, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.,
        children: [
          WebButton(githubId, 'assets/icons/github.svg'),
          WebButton(blogUrl, 'assets/icons/blog.svg'),
        ],
      ),
    );
  }
}