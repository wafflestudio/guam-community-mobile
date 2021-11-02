import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/posts/post_preview_banner.dart';
import 'package:guam_community_client/screens/boards/posts/post_preview_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

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
          color: GuamColorFamily.grayscaleWhite,
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
                color: GuamColorFamily.grayscaleGray7,
              ),
              Row(
                children: [
                  if (post.pictures.length > 0)
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: SvgPicture.asset(
                      'assets/icons/picture.svg',
                      color: GuamColorFamily.grayscaleGray5,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Text(
                    post.title,
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                post.content,
                style: TextStyle(
                  height: 1.4,
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray4,
                ),
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
