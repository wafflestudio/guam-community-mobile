import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/profiles/profile.dart';
import '../../../providers/user_auth/authenticate.dart';

class ProfileEditTextField extends StatefulWidget {
  final String input;
  final int maxLength;

  ProfileEditTextField({this.input, this.maxLength});

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
    final Profile me = context.read<Authenticate>().me;

    return Expanded(
      child: TextField(
        maxLength: widget.maxLength,
        controller: _textFieldController,
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
