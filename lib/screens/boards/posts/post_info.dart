import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../commons/common_img_nickname.dart';

class PostInfo extends StatelessWidget {
  final Post post;
  final double iconSize;
  final bool showProfile;
  final bool profileClickable;
  final HexColor iconColor;

  PostInfo({
    this.post,
    this.iconSize = 20,
    this.showProfile = true,
    this.profileClickable = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showProfile)
          CommonImgNickname(
            userId: post.profile.id,
            imgUrl: post.profile.profileImg != null ? post.profile.profileImg.urlPath : null,
            nickname: post.profile.nickname,
            profileClickable: profileClickable,
            nicknameColor: GuamColorFamily.grayscaleGray2,
          ),
        if (showProfile) Spacer(),
        Row(
          children: [
            IconText(
              iconSize: iconSize,
              text: post.like.toString(),
              iconPath: post.isLiked
                  ? 'assets/icons/like_filled.svg'
                  : 'assets/icons/like_outlined.svg',
              onPressed: (){},
              iconColor: post.isLiked
                  ? GuamColorFamily.redCore
                  : iconColor,
              textColor: iconColor,
            ),
            IconText(
              iconSize: iconSize,
              text: post.commentCnt.toString(),
              iconPath: 'assets/icons/comment.svg',
              iconColor: iconColor,
              textColor: iconColor,
            ),
            IconText(
              iconSize: iconSize,
              text: post.scrap.toString(),
              iconPath: post.isScrapped
                  ? 'assets/icons/scrap_filled.svg'
                  : 'assets/icons/scrap_outlined.svg',
              onPressed: (){},
              iconColor: post.isScrapped
                  ? GuamColorFamily.purpleCore
                  : iconColor,
              textColor: iconColor,
            ),
          ],
        ),
      ],
    );
  }
}
