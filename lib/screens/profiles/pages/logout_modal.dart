import 'package:flutter/material.dart';

import '../../../commons/custom_divider.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class LogoutModal extends StatelessWidget {
  final Function func;

  LogoutModal({required this.func});

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
                  '정말 로그아웃 하시겠어요?',
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
                '다시 로그인할 사람 괌!',
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
                  '로그아웃',
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
