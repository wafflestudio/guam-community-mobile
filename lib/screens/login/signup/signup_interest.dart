import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class SignupInterest extends StatefulWidget {
  final Map input;
  final Function startButton;

  SignupInterest(this.input, this.startButton);

  @override
  State<SignupInterest> createState() => _SignupInterestState();
}

class _SignupInterestState extends State<SignupInterest> {
  void _setInterest(String interest) => setState(() => widget.input['interest'] = interest);

  @override
  Widget build(BuildContext context) {
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
            '관심사를 모두 선택해주세요.',
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
            '맞춤형 피드를 위해 관심사를 알려주세요.',
            style: TextStyle(
              height: 1.6,
              fontSize: 18,
              color: GuamColorFamily.grayscaleGray3,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
          ),
        ),
      ],
    );
  }
}
