import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../../commons/custom_app_bar.dart';
import '../buttons/long_button.dart';
import 'blacklist_edit.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          leading: Back(),
          title: '계정 설정',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Wrap(
              runSpacing: 12,
              children: [
                LongButton(
                  label: '차단 목록 관리',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlackListEdit()
                    )
                  )
                ),
                LongButton(
                  label: '로그아웃',
                  onPressed: () {}
                ),
              ],
            ),
          ),
        )
    );
  }
}
