import 'package:flutter/material.dart';
import '../buttons/profile_bottom_button.dart';

class ProfileBottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: [
          ProfileBottomButton('내가 쓴 글', () {}),
          Padding(padding: EdgeInsets.only(bottom: 12)),
          ProfileBottomButton('저장한 글', () {}),
          Padding(padding: EdgeInsets.only(bottom: 12)),
          ProfileBottomButton('계정 설정', () {}),
        ],
      ),
    );
  }
}