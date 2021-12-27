import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class SignupNickname extends StatefulWidget {
  final Map input;
  final Function nextButton;

  SignupNickname(this.input, this.nextButton);

  @override
  State<SignupNickname> createState() => _SignupNicknameState();
}

class _SignupNicknameState extends State<SignupNickname> {
  final _nicknameTextFieldController = TextEditingController();

  void _setNickname(String nickname) =>
      setState(() => widget.input['nickname'] = nickname);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.all(4.67),
          constraints: BoxConstraints(),
          icon: SvgPicture.asset('assets/icons/baloon.svg'),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'IT인들의 괌에\n오신 것을 환영합니다!',
            style: TextStyle(
              height: 1.6,
              fontSize: 24,
              color: GuamColorFamily.grayscaleGray1,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            '사용하실 닉네임을\n10자 이내로 입력해주세요.',
            style: TextStyle(
              height: 1.6,
              fontSize: 18,
              color: GuamColorFamily.grayscaleGray3,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
          ),
        ),
        TextField(
          style: TextStyle(fontSize: 16),
          keyboardType: TextInputType.name,
          controller: _nicknameTextFieldController,
          minLines: 1,
          maxLength: widget.input['nickname'] == '' ? null : 10,
          onChanged: (e) {
            _setNickname(_nicknameTextFieldController.text);
            // _checkButtonEnable();
          },
          cursorColor: GuamColorFamily.purpleCore,
          decoration: InputDecoration(
            hintText: "ex) 크로플보다와플",
            hintStyle: TextStyle(
              fontSize: 16,
              color: GuamColorFamily.grayscaleGray4,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
            counterStyle: TextStyle(
              color: GuamColorFamily.purpleCore,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              fontSize: 12,
            ),
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: UnderlineInputBorder(borderSide: BorderSide(color: GuamColorFamily.purpleCore)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: GuamColorFamily.purpleCore)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: GuamColorFamily.grayscaleGray5)),
            contentPadding: EdgeInsets.only(left: 14, top: 77, bottom: 13),
          ),
        ),
      ],
    );
  }
}
