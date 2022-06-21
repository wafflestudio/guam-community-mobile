import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';

class Back extends StatelessWidget {
  final Function onPressed;

  Back({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: GuamColorFamily.grayscaleWhite,
      margin: EdgeInsets.zero,
      child: IconButton(
        icon: SvgPicture.asset('assets/icons/back.svg'),
        onPressed: () {
          Navigator.maybePop(context);
          if (onPressed != null) onPressed();
        }
      ),
    );
  }
}
