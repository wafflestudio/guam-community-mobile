import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../../commons/custom_app_bar.dart';

class SavedPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          leading: Back(),
          title: '저장한 글',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              children: []
            ),
          ),
        )
    );
  }
}
