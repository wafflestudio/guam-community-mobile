import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class ButtonSizeCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox (
        width: 20,
        height: 20,
        child: CircularProgressIndicator(color: GuamColorFamily.purpleCore),
      ),
    );
  }
}
