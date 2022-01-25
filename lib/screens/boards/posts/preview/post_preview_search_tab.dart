import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_interest.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import '../post_info.dart';

class PostPreviewSearchTab extends StatelessWidget {
  final Post post;

  PostPreviewSearchTab(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (post.pictures.length > 0)
              IconButton(
                padding: EdgeInsets.only(right: 4),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
        ),
        PostPreviewInterest(post),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            post.content,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 20.8/13,
              fontSize: 13,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray3,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              post.boardType,
              style: TextStyle(
                fontSize: 12,
                height: 19.2/12,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray4,
              ),
            ),
            Spacer(),
            Text(
              (DateTime.now().minute - post.createdAt.minute).toString() + "분 전",
              style: TextStyle(
                fontSize: 10,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray4,
              ),
            )
          ],
        ),
        PostInfo(
          post: post,
          iconColor: GuamColorFamily.grayscaleGray5,
        )
      ],
    );
  }
}
