import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_alert.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/comments/comment_more.dart';
import 'package:guam_community_client/screens/boards/posts/post_comment_report.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../commons/bottom_modal/bottom_modal_with_message.dart';
import '../../../models/profiles/profile.dart';

class CommentBanner extends StatefulWidget {
  final Comment comment;

  CommentBanner(this.comment);

  @override
  State<CommentBanner> createState() => _CommentBannerState();
}

class _CommentBannerState extends State<CommentBanner> {
  Profile myProfile;

  @override
  void initState() {
    super.initState();
    myProfile = context.read<Authenticate>().me;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          CommonImgNickname(
            userId: widget.comment.profile.id,
            imgUrl: widget.comment.profile.profileImg != null ? widget.comment.profile.profileImg.urlPath : null,
            nickname: widget.comment.profile.nickname,
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
              builder: (context) => CommentMore(
                comment: widget.comment,
                isMe: widget.comment.profile.id == myProfile.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
