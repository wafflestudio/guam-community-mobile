import 'package:flutter/material.dart';

import '../../../commons/custom_divider.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class WithdrawalModal extends StatelessWidget {
  final Function func;

  WithdrawalModal({required this.func});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '정말 계정을 삭제하시겠어요?',
                  style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    '돌아가기',
                    style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(30, 26),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ],
            ),
            CustomDivider(color: GuamColorFamily.grayscaleGray7),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '계정 삭제 이후에는 작성한 게시글과 댓글을 수정/삭제할 수 없으며, 쪽지 기록이 초기화됩니다.',
                style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  func();
                  Navigator.pop(context);
                },
                child: Text(
                  '계정 삭제',
                  style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
