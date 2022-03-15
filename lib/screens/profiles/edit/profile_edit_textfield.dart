import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class ProfileEditTextField extends StatefulWidget {
  final String input;
  final int maxLength;
  final bool isBlogUrl;
  final Function func; /// request body 에 쓰일 setInput 함수
  final String funcKey; /// nickname, introduction, blogUrl 이 위 func 에 사용되는 argument

  ProfileEditTextField({this.input, this.maxLength, this.isBlogUrl=false, this.func, this.funcKey});

  @override
  State<ProfileEditTextField> createState() => _ProfileEditTextFieldState();
}

class _ProfileEditTextFieldState extends State<ProfileEditTextField> {
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    _textFieldController.text = widget.input;
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        maxLength: widget.maxLength,
        controller: _textFieldController,
        onChanged: (e) => widget.func(widget.funcKey, _textFieldController.text),
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
          hintText: widget.isBlogUrl
            ? 'https://guam.com'
            : '',
          hintStyle: TextStyle(
            color: GuamColorFamily.grayscaleGray4,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            fontSize: 13,
          ),
        ),
      )
    );
  }
}
