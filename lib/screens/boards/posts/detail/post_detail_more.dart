import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../commons/bottom_modal/bottom_modal_default.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_alert.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_message.dart';
import '../../../../models/boards/post.dart';
import '../../../../providers/posts/posts.dart';
import '../creation/post_creation.dart';
import '../post_comment_report.dart';

class PostDetailMore extends StatelessWidget {
  final Post post;
  final Function getEditedPost;

  PostDetailMore(this.post, this.getEditedPost);

  @override
  Widget build(BuildContext context) {
    _navigatePage(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: context.read<Posts>(),
            child: PostCreation(isEdit: true, editTarget: post),
          ),
        ),
      );
      getEditedPost(result);
    }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: post.isMine ? [
            BottomModalDefault(
              text: '수정하기',
              onPressed: () => _navigatePage(context),
            ),
            BottomModalWithAlert(
              funcName: '삭제하기',
              title: '게시글을 삭제하시겠어요?',
              body: '삭제된 게시글은 복원할 수 없습니다.',
              func: () async {
                await context.read<Posts>().deletePost(post.id)
                    .then((successful) {
                  if (successful) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (route) => true
                    );
                  }
                });
              },
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
