import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/back.dart';
import '../../../commons/custom_app_bar.dart';

class InterestsEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: Back(),
          title: '관심사 관리',
        ),
        body: SingleChildScrollView(
          child: Column(),
        )
    );
  }
}
