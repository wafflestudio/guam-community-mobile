import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/screens/boards/comments/comment_more.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentBanner extends StatelessWidget {
  final Comment comment;

  CommentBanner(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          CommonImgNickname(
            userId: comment.profile.id,
            imgUrl: comment.profile.profileImg ?? null,
            nickname: comment.profile.nickname,
            nicknameColor: GuamColorFamily.grayscaleGray3,
          ),
          Spacer(),
          IconButton(
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: GuamColorFamily.grayscaleGray5,
            ),
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: GuamColorFamily.grayscaleWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              builder: (context) => CommentMore(comment),
            ),
          ),
        ],
      ),
    );
  }
}
