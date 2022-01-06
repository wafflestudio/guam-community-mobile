import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../commons/custom_app_bar.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(title: '검색'),
    );
  }
}
