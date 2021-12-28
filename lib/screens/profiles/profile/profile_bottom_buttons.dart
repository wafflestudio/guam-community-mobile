import 'package:flutter/material.dart';
import '../buttons/long_button.dart';
import '../pages/my_posts.dart';
import '../pages/saved_posts.dart';
import '../pages/settings.dart';

class ProfileBottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Wrap(
        runSpacing: 12,
        children: [
          LongButton(
            label: '내가 쓴 글',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyPosts()
              )
            )
          ),
          LongButton(
            label: '저장한 글',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SavedPosts()
              )
            )
          ),
          LongButton(
            label: '계정 설정',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Settings()
              )
            )
          ),
        ],
      ),
    );
  }
}
