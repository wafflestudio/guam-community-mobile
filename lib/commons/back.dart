import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class Back extends StatelessWidget {
  final HexColor? bgColor;
  final HexColor? iconColor;
  final Function? onPressed;

  Back({this.bgColor, this.iconColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: bgColor != null
          ? bgColor
          : GuamColorFamily.grayscaleWhite,
      margin: EdgeInsets.zero,
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: iconColor,
        ),
        onPressed: () {
          Navigator.maybePop(context);
          if (onPressed != null) onPressed!();
        }
      ),
    );
  }
}
