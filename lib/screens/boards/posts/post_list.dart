import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/post_preview.dart';

import '../../../commons/sub_headings.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsProvider = context.read<Posts>();

    return Container(
      decoration: BoxDecoration(color: HexColor('#F9F8FF')), // background color
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 22, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadings("특별한 일이 있나요? ✨"),
                IconText(
                  text: "관심사 설정",
                  iconPath: 'assets/icons/setting.svg',
                  onPressed: (){},
                  iconHexColor: HexColor('#9F8FFF'),
                  textHexColor: HexColor('#9F8FFF'),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ...postsProvider.posts.map((post) => PostPreview(post, postsProvider))
            ]
          )
        ],
      ),
    );
  }
}
