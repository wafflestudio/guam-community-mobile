import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';

import '../../../commons/sub_headings.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsProvider = context.read<Posts>();

    return Container(
      decoration: BoxDecoration(color: GuamColorFamily.purpleLight3), // background color
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24, left: 22, right: 10, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadings("특별한 일이 있나요? ✨"),
                IconText(
                  text: "관심사 설정",
                  iconPath: 'assets/icons/setting.svg',
                  onPressed: (){},
                  iconColor: GuamColorFamily.purpleLight1,
                  textColor: GuamColorFamily.purpleLight1,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                ...postsProvider.posts.map((post) => PostPreview(post, postsProvider))
              ]
            ),
          )
        ],
      ),
    );
  }
}
