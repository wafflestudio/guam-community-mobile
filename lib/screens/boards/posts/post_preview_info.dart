import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PostPreviewInfo extends StatelessWidget {
  final Post post;

  PostPreviewInfo(this.post);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 8, right: 8),
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: post.profile.profileImageUrl != null
                        ? NetworkImage(post.profile.profileImageUrl)
                        : SvgProvider('assets/icons/profile_image.svg')
                  ),
                ),
              ),
            ),
            Text(
              post.profile.nickname,
              style: TextStyle(
                fontSize: 12,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray3,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          children: [
            IconText(
              text: post.like.toString(),
              iconPath: post.isLiked
                  ? 'assets/icons/like_filled.svg'
                  : 'assets/icons/like_outlined.svg',
              onPressed: (){},
              iconHexColor: post.isLiked
                  ? GuamColorFamily.redCore
                  : GuamColorFamily.grayscaleGray5,
              textHexColor: GuamColorFamily.grayscaleGray5,
            ),
            IconText(
              text: post.commentCnt.toString(),
              iconPath: 'assets/icons/comment.svg',
              iconHexColor: GuamColorFamily.grayscaleGray5,
              textHexColor: GuamColorFamily.grayscaleGray5,
            ),
            IconText(
              text: post.scrap.toString(),
              iconPath: post.isScrapped
                  ? 'assets/icons/scrap_filled.svg'
                  : 'assets/icons/scrap_outlined.svg',
              onPressed: (){},
              iconHexColor: post.isScrapped
                  ? GuamColorFamily.purpleCore
                  : GuamColorFamily.grayscaleGray5,
              textHexColor: GuamColorFamily.grayscaleGray5,
            ),
          ],
        ),
      ],
    );
  }
}
