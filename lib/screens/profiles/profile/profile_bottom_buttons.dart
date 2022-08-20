import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/posts/posts.dart';
import '../buttons/long_button.dart';
import '../pages/my_posts.dart';
import '../pages/scrapped_posts.dart';
import '../pages/settings.dart';

class ProfileBottomButtons extends StatelessWidget {
  _launchURL(String urlPath) async {
    final String url = 'https://guam.wafflestudio.com';
    if (!await launch(url + urlPath)) throw 'Could not launch ${url + urlPath}';
  }

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
          TextButton(onPressed: () => _launchURL('/terms_of_service'), child: Text('이용약관')),
          TextButton(onPressed: () => _launchURL('/privacy_policy'), child: Text('개인정보처리방침'))
        ],
      ),
    );
  }
}
