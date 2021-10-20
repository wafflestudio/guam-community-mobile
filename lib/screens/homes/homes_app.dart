import 'package:flutter/material.dart';
import '../../commons/custom_app_bar.dart';
import 'homes_body.dart';

class HomesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '홈',
        trailing: Icon(Icons.message),
      ),
      body: HomesBody(),
    );
  }
}
