import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class PostCreationInterest extends StatefulWidget {
  final Map input;

  PostCreationInterest(this.input);

  @override
  _PostCreationInterestState createState() => _PostCreationInterestState();
}

class _PostCreationInterestState extends State<PostCreationInterest> {
  String interest;

  @override
  void initState() {
    super.initState();
  }

  void setBoardType(){
    setState(() {
      interest = '데이터분석';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            '태그를 선택해주세요.',
            style: TextStyle(
              fontSize: 14,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              color: GuamColorFamily.grayscaleGray3,
            )
          ),
        ),
      ],
    );
  }
}
