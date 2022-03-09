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
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: [
          if (showProfile)
            CommonImgNickname(
              imgUrl: post.profile.profileImg,
              nickname: post.profile.nickname,
              profileClickable: profileClickable,
              nicknameColor: GuamColorFamily.grayscaleGray2,
            ),
          if (showProfile) Spacer(),
          Row(
            children: [
              IconText(
                iconSize: iconSize,
                text: post.likeCount.toString(),
                iconPath: post.isLiked ?? false  /// 서버 수정 후 ?? false 삭제
                    ? 'assets/icons/like_filled.svg'
                    : 'assets/icons/like_outlined.svg',
                onPressed: (){},
                iconColor: post.isLiked ?? false  /// 서버 수정 후 ?? false 삭제
                    ? GuamColorFamily.redCore
                    : iconColor,
                textColor: iconColor,
              ),
              IconText(
                iconSize: iconSize,
                text: post.commentCount.toString(),
                iconPath: 'assets/icons/comment.svg',
                iconColor: iconColor,
                textColor: iconColor,
              ),
              IconText(
                iconSize: iconSize,
                text: post.scrapCount.toString(),
                iconPath: post.isScrapped ?? false  /// 서버 수정 후 ?? false 삭제
                    ? 'assets/icons/scrap_filled.svg'
                    : 'assets/icons/scrap_outlined.svg',
                onPressed: (){},
                iconColor: post.isScrapped ?? false  /// 서버 수정 후 ?? false 삭제
                    ? GuamColorFamily.purpleCore
                    : iconColor,
                textColor: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
