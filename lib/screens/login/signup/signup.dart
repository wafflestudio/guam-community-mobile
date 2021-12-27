import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/next_button.dart';
import 'package:guam_community_client/screens/login/signup/signup_interest.dart';
import 'package:guam_community_client/screens/login/signup/signup_nickname.dart';
import 'package:guam_community_client/styles/colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map input = {'nickname': '', 'interest': []};
  bool btnEnabled = false;
  int page = 1;

  void _nextButton() => setState(() {
    if (input['nickname'] != '') {
      page++;
      btnEnabled = true;
    }
  });

  void _startButton() => setState(() {});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          color: GuamColorFamily.grayscaleWhite,
          padding: EdgeInsets.only(left: 16, top: size.height*0.11, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (page==1) SignupNickname(input, _nextButton),
              if (page==2) SignupInterest(input, _startButton),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: NextButton(
                  label: page==1 ? '다음' : '시작',
                  onTap: _nextButton,
                  btnEnabled: btnEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
