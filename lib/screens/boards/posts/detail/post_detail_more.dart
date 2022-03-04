import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../commons/bottom_modal/bottom_modal_default.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_alert.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_message.dart';
import '../../../../models/boards/post.dart';
import '../../../../models/profiles/profile.dart';
import '../../../../providers/user_auth/authenticate.dart';
import '../creation/post_creation.dart';
import '../post_comment_report.dart';

class PostDetailMore extends StatelessWidget {
  final Post post;

  PostDetailMore(this.post);

  @override
  Widget build(BuildContext context) {
    Profile myProfile = context.read<Authenticate>().me;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: post.profile.id == myProfile.id ? [
            BottomModalDefault(
              text: '수정하기',
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PostCreation(
                    isEdit: true,
                    editTarget: post, // 수정할 대상 (Post)
                  ),
                ),
              ),
            ),
            BottomModalWithAlert(
              funcName: '삭제하기',
              title: '게시글을 삭제하시겠어요?',
              body: '삭제된 게시글은 복원할 수 없습니다.',
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
                    child: BottomModalWithMessage(
                      funcName: '보내기',
                      title: '${post.profile.nickname} 님에게 쪽지 보내기',
                      profile: post.profile,
                      func: null,
                    ),
                  ),
                ),
              ),
            ),
            PostCommentReport(post.profile),
            BottomModalWithAlert(
              funcName: '차단하기',
              title: '${post.profile.nickname} 님을 차단하시겠어요?',
              body: '사용자를 차단하면, 해당 사용자의 게시글 및 댓글을 확인 할 수 없으며, 서로 쪽지를 주고 받을 수 없습니다.\n\n차단계정 관리는 프로필>계정 설정> 차단 목록 관리 탭에서 확인 가능합니다',
              func: () {},
            ),
          ],
        ),
      ),
    );
  }
}