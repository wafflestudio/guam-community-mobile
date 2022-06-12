import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../../commons/icon_text.dart';

class WebButton extends StatelessWidget {
  final String url;
  final String iconPath;

  WebButton(this.url, this.iconPath);

  @override
  Widget build(BuildContext context) {
    return IconText(
      iconSize: 24,
      iconPath: iconPath,
      iconColor: GuamColorFamily.grayscaleGray5,
      paddingBtw: 0,
      onPressed: _launchURL,
    );
  }

  void _launchURL() async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}