import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'notifications_body.dart';
import '../../commons/custom_app_bar.dart';

class NotificationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(title: '알림'),
      body: NotificationsBody(),
    );
  }
}
