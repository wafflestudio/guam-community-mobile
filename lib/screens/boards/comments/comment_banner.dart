import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/screens/boards/comments/comment_more.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview_relative_time.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../models/profiles/profile.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../styles/fonts.dart';

class CommentBanner extends StatelessWidget {
  final Comment comment;

  CommentBanner(this.comment);

  @override
  Widget build(BuildContext context) {
    final Profile me = context.read<Authenticate>().me;

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
          if (comment.profile.id == me.id)
            Container(
              margin: EdgeInsets.only(left: 4),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              decoration: BoxDecoration(
                color: GuamColorFamily.purpleLight3,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                '작성자',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.purpleLight1,
                ),
              ),
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
