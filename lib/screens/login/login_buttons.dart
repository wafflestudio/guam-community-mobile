import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/user_auth/google_login.dart';
import '../user_auth/kakao_login.dart';

class LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KakaoLogin(),
        GoogleLogin(),
      ],
    );
  }
}
