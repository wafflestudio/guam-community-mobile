import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class SplashText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'IT인들의 커뮤니티',
              style: TextStyle(
                fontSize: 18,
                color: GuamColorFamily.grayscaleWhite,
              )
          ),
          Text(
              'Guam',
              style: TextStyle(
                fontSize: 56,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: GuamColorFamily.purpleDark1,
              )
          )
        ],
      ),
    );
  }
}
