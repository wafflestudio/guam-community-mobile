import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'login_button.dart';
import '../user_auth/kakao_login.dart';

class LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KakaoLogin(),
        LoginButton('google_logo', '구글로 시작하기', GuamColorFamily.grayscaleWhite, () {}),
      ],
    );
  }
}
