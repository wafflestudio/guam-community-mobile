import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_category.dart';
import 'package:guam_community_client/styles/colors.dart';

import './post_preview_board_type.dart';
import './post_preview_content.dart';
import './post_preview_relative_time.dart';
import './post_preview_title.dart';
import '../post_info.dart';

class PostPreviewHomeTab extends StatelessWidget {
  final int idx;
  final Post post;
  final bool isAnonymous;
  final Function refreshPost;

  PostPreviewHomeTab(this.idx, this.post, this.refreshPost)
      : this.isAnonymous = post.boardType == '익명게시판';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            this.isAnonymous
                ? PostPreviewBoardType(this.post.boardType)
                : post.category != null
                    ? PostPreviewCategory(post)
                    : Container(),
            Spacer(),
            PostPreviewRelativeTime(DateTime.parse(this.post.createdAt)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
        ),
        Row(
          children: [
            if (post.imagePaths.isNotEmpty)
              IconButton(
                onPressed: null,
                padding: EdgeInsets.only(right: 4),
                constraints: BoxConstraints(),
                icon: SvgPicture.asset(
                  'assets/icons/picture.svg',
                  color: GuamColorFamily.grayscaleGray5,
                  width: 20,
                  height: 20,
                ),
              ),
            PostPreviewTitle(this.post.title),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: PostPreviewContent(this.post.content),
        ),
        PostInfo(
          index: idx,
          post: post,
          refreshPost: refreshPost,
          iconColor: GuamColorFamily.grayscaleGray5,
          profileClickable: false,
        ),
      ],
    );
  }
}
