import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import '../../../../commons/button_size_circular_progress_indicator.dart';

class ProfileEditSkillSetTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileEditSkillSetTextFieldState();
}

class ProfileEditSkillSetTextFieldState extends State<ProfileEditSkillSetTextField> {
  bool sending = false;

  void toggleSending() {
    setState(() => sending = !sending);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray1,
              height: 22.4/14
            ),
            cursorColor: GuamColorFamily.purpleCore,
            decoration: InputDecoration(
              hintText: "스택을 입력해주세요",
              hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            ),
            ),
          ),
          !sending ? TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 6),
              minimumSize: Size(30, 26),
              alignment: Alignment.center,
            ),
            child: Text(
              '등록',
              style: TextStyle(
                color: GuamColorFamily.purpleCore,
                fontSize: 14,
              ),
            ),
          ) : ButtonSizeCircularProgressIndicator()
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: GuamColorFamily.grayscaleGray6,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      margin: EdgeInsets.only(bottom: 12),
    );
  }
}
