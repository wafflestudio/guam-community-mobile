import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class ProfileEditTextField extends StatelessWidget {
  final int maxLength;  // Give value only when needed

  ProfileEditTextField({this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        maxLength: maxLength,
        maxLines: null,
        style: TextStyle(
          fontSize: 14,
          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
          color: GuamColorFamily.grayscaleGray1,
          height: 22.4/14
        ),
        cursorColor: GuamColorFamily.purpleCore,
        decoration: InputDecoration(
          counterStyle: TextStyle(
            color: GuamColorFamily.purpleCore,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            fontSize: 12
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: GuamColorFamily.purpleLight2)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: GuamColorFamily.purpleLight2)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: GuamColorFamily.purpleLight2)
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 8),
        ),
      )
    );
  }
}
