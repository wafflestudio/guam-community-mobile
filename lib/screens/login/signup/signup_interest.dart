import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/screens/login/signup/interest_choice_chip.dart';
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
  final List<String> interestOptions = [
    '🛠 개발', '📈 데이터분석', '🎨 디자인','📝 기획/마케팅', '🎁 기타',
  ];
  Map results = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
        _selectInterests(interestOptions, size)
      ],
    );
  }

  Widget _selectInterests(List<String> interestOptions, Size size) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(top: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InterestChoiceChip(
            interestList: widget.input['interest'].cast<String>(), // convert List<dynamic> to List<String>
            interestOptions: interestOptions,
            onSelectionChanged: (selectedList) {
              setState(() => widget.input['interest'] = selectedList);
            },
          ),
        ],
      ),
    );
  }
}
