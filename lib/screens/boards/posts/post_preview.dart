import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/post_preview_banner.dart';
import 'package:guam_community_client/screens/boards/posts/post_preview_info.dart';
import 'package:hexcolor/hexcolor.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  final Posts postsProvider;

  PostPreview(this.post, this.postsProvider);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 24, right: 24, top: 12),
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          borderRadius: BorderRadius.circular(24)
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostPreviewBanner(post),
              Divider(
                thickness: 1,
                color: HexColor('#F2F2F2'),
              ),
              Text(
                post.title,
                style: TextStyle(fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                post.content,
                style: TextStyle(fontSize: 12, color: HexColor('A0A0A0')),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              PostPreviewInfo(post)
            ],
          ),
        ),
      ),
    );
  }
}
