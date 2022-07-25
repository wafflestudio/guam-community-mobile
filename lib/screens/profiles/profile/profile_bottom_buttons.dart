import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/posts/posts.dart';
import '../buttons/long_button.dart';
import '../pages/my_posts.dart';
import '../pages/scrapped_posts.dart';
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
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<Posts>(),
                  child: MyPosts(),
                ),
              ),
            ),
          ),
          LongButton(
            label: '스크랩한 글',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<Posts>(),
                  child: ScrappedPosts(),
                ),
              ),
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
