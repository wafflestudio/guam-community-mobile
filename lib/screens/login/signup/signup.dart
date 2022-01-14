import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/next_button.dart';
import 'package:guam_community_client/screens/app/app.dart';
import 'package:guam_community_client/screens/login/signup/signup_interest.dart';
import 'package:guam_community_client/screens/login/signup/signup_nickname.dart';
import 'package:guam_community_client/styles/colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map input = {'nickname': '', 'interest': []};
  int page = 1;

  void _nextButton() => setState(() {
    if (input['nickname'] != '' && page < 2) {
      page++;
    }
  });

  // void _startButton() => setState(() {page--;});
  void _startButton() {
    Navigator.of(context).push(
      // 닉네임 & 관심사 API 날리기
      MaterialPageRoute(builder: (_) => App()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              if (page==1) SignupNickname(input, _nextButton),
              if (page==2) SignupInterest(input, _startButton),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: NextButton(
                    label: page==1 ? '다음' : '시작',
                    onTap: page==1 ? _nextButton : _startButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
