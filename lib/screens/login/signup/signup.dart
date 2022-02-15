import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/next_button.dart';
import 'package:guam_community_client/screens/login/signup/signup_nickname.dart';
import 'package:guam_community_client/styles/colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map input = {};
  int pageIdx = 0;

  void signUp() {
    print(input);
    // TODO: post 2 apis 1 ) set user profile 2) set user interest
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      SignupNickname(input)
    ];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          color: GuamColorFamily.grayscaleWhite,
          padding: EdgeInsets.only(left: 16, top: size.height*0.11, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pages[pageIdx],
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: NextButton(
                  label: pageIdx < pages.length - 1 ? '다음' : '시작',
                  onTap: pageIdx < pages.length - 1 ? pageIdx++ : signUp
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
