import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'search_app_bar.dart';
import 'search_app_textfield.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: SearchAppBar(
        title: SearchAppTextField(),
      ),
      // body: ,
    );
  }
}
