import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../edit/interests/interests_edit_label.dart';
import '../edit/interests/interests_edit_textfield.dart';
import '../edit/profile_edit_label.dart';
import '../buttons/interest_button.dart';

class InterestsEdit extends StatelessWidget {
  final List<String> myInterestsList = ['디자인', '기획/마케팅', 'NLP', '네트워크'];
  final List<String> interestsList = ['디자인', '기획/마케팅', '기타', '개발', '데이터분석',
    '소프트웨어', '프론트엔드', '백엔드', '시스템', '딥러닝', '머신러닝', 'NLP', '네트워크', '보안'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '관심사 관리',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InterestsEditLabel(myInterestsList.length),
                InterestsEditTextField(),
                Padding(
                  child: ProfileEditLabel('내 관심사'),
                  padding: EdgeInsets.only(bottom: 12),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [...myInterestsList.map((i) => InterestButton(i, deletable: true))],
                ),
                Padding(
                  child: ProfileEditLabel('관심사 목록'),
                  padding: EdgeInsets.only(top: 15, bottom: 12),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [...interestsList.map((i) => InterestButton(i))],
                )
              ],
            ),
          ),
        )
    );
  }
}
