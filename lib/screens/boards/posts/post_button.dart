import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: GuamColorFamily.purpleCore,
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/write.svg',
              color: GuamColorFamily.grayscaleWhite,
              width: 30,
              height: 30,
            ),
            onPressed: () {}
          ),
        ),
      ),
    );
  }
}
