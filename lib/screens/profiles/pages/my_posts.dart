import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../commons/custom_app_bar.dart';

class MyPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '내가 쓴 글',
        ),
        body: SingleChildScrollView(
          child: Column(),
        )
    );
  }
}
