import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'login_button.dart';

class LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoginButton('kakao_logo', '카카오톡으로 시작하기', GuamColorFamily.kakaoYellow),
        LoginButton('google_logo', '구글로 시작하기', GuamColorFamily.grayscaleWhite),
      ],
    );
  }
}
