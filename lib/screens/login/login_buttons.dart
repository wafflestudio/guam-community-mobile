import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/user_auth/apple_login.dart';
import 'package:guam_community_client/screens/user_auth/google_login.dart';
import '../../styles/colors.dart';
import '../user_auth/kakao_login.dart';

class LoginButtons extends StatefulWidget {
  @override
  State<LoginButtons> createState() => _LoginButtonsState();
}

class _LoginButtonsState extends State<LoginButtons> {
  bool _loading = false;

  void setLoading(bool) {
    setState(() => _loading = bool);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator(color: GuamColorFamily.purpleCore)
        : Column(
            children: [
              KakaoLogin(setLoading),
              GoogleLogin(setLoading),
              if (Platform.isIOS) AppleLogin(setLoading),
            ],
          );
  }
}
