import 'package:flutter/material.dart';
import 'notifications_body.dart';
import '../../commons/custom_app_bar.dart';

class NotificationsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '알림'),
      body: NotificationsBody(),
    );
  }
}
