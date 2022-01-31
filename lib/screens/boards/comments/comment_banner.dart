import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_alert.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_text.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/providers/profiles/profiles.dart';
import 'package:guam_community_client/screens/boards/posts/post_comment_report.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

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
    myProfile = context.read<MyProfile>().myProfile;
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
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.comment.profile.id == myProfile.id ? [
                      BottomModalDefault(
                        text: '수정하기',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      BottomModalWithAlert(
                        funcName: '삭제하기',
                        title: '댓글을 삭제하시겠어요?',
                        body: '삭제된 댓글은 복원할 수 없습니다.',
                        func: () {},
                      ),
                    ] : [
                      BottomModalDefault(
                        text: '쪽지 보내기',
                        onPressed: () => showMaterialModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Container(
                            child: SingleChildScrollView(
                              child: BottomModalWithText(
                                funcName: '보내기',
                                title: '${widget.comment.profile.nickname} 님에게 쪽지 보내기',
                                profile: widget.comment.profile,
                                func: null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PostCommentReport(widget.comment.profile),
                      BottomModalWithAlert(
                        funcName: '차단하기',
                        title: '${widget.comment.profile.nickname} 님을 차단하시겠어요?',
                        body: '사용자를 차단하면, 해당 사용자의 게시글 및 댓글을 확인 할 수 없으며, 서로 쪽지를 주고 받을 수 없습니다.\n\n차단계정 관리는 프로필>계정 설정> 차단 목록 관리 탭에서 확인 가능합니다',
                        func: () {},
                      ),
                    ],
                  ),
                ),
              )
            )
          ),
        ],
      ),
    );
  }
}
