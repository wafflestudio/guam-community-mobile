import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../commons/bottom_modal/bottom_modal_default.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_alert.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_message.dart';
import '../../../../commons/bottom_modal/bottom_modal_with_report.dart';
import '../../../../models/boards/post.dart';
import '../../../../providers/messages/messages.dart';
import '../../../../providers/posts/posts.dart';
import '../../../../providers/share/share.dart';
import '../../../../providers/user_auth/authenticate.dart';
import '../creation/post_creation.dart';

class PostDetailMore extends StatelessWidget {
  final Post? post;
  final Function getEditedPost;

  PostDetailMore(this.post, this.getEditedPost);

  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();
    final share = Share(context: context);

    void _navigatePage(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => Posts(authProvider)),
              ChangeNotifierProvider(create: (_) => Messages(authProvider)),
            ],
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
          children: post!.isMine! ? [
            BottomModalDefault(
              text: '게시글 공유하기',
              onPressed: () => share.share(post!.id, post!.title),
            ),
            BottomModalDefault(
              text: '수정하기',
              onPressed: () => _navigatePage(context),
            ),
            BottomModalWithAlert(
              funcName: '삭제하기',
              title: '게시글을 삭제하시겠어요?',
              body: '삭제된 게시글은 복원할 수 없습니다.',
              func: () async {
                await context.read<Posts>().deletePost(post!.id)
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
              text: '게시글 공유하기',
              onPressed: () => share.share(post!.id, post!.title),
            ),
            /// Deprecated: until 'if (widget.post.profile.id != 0)' exists in PostDetail
            if (post!.profile!.id != 0)
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
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Messages(authProvider)),
                  ],
                  child: SingleChildScrollView(
                    child: BottomModalWithMessage(
                      funcName: '보내기',
                      title: '${post!.profile!.nickname} 님에게 쪽지 보내기',
                      profile: post!.profile,
                      func: null,
                    ),
                  ),
                ),
              ),
            ),
            BottomModalWithReport(reportId: post!.id!, profile: post!.profile!),
            BottomModalWithAlert(
              funcName: '차단하기',
              title: '${post!.profile!.nickname} 님을 차단하시겠어요?',
              body: '사용자를 차단하면 쪽지를 주고 받을 수 없습니다.\n\n차단계정 관리는 프로필>계정 설정>차단 목록 관리 탭에서 확인 가능합니다',
              func: () async {
                await context.read<Authenticate>().blockUser(post!.profile!.id)
                    .then((successful) {
                  if (successful) {
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
