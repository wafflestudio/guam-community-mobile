import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/next_button.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/screens/login/signup/signup_nickname.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_auth/authenticate.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with Toast {
  Map<String, dynamic> input = {};
  int pageIdx = 0;


  @override
  Widget build(BuildContext context) {
    List pages = [
      SignupNickname(input)
    ];

    Size size = MediaQuery.of(context).size;

    Future signUp() async {
      input['updateImage'] = false;
      if (input['nickname'] == '') {
        showToast(success: false, msg: '닉네임을 입력해주세요.');
        return null;
      }
      await context.read<Authenticate>().setProfile(fields: input);
    }

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
                  onTap: pageIdx < pages.length - 1 ? pageIdx++ as Function : signUp
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
