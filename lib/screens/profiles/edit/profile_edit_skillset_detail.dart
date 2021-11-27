import 'package:flutter/material.dart';
import '../../../commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/back.dart';

class ProfileEditSkillSetDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '프로필 수정',
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              ],
            ),
          ),
        )
    );
  }
}
