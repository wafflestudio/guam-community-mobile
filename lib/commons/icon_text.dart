import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class IconText extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final double paddingBtw;
  final String text;
  final String iconPath;
  final Function onPressed;
  final HexColor iconColor;
  final HexColor textColor;

  IconText({this.iconSize=20, this.fontSize=12, this.paddingBtw=10, this.text="", this.iconPath, this.onPressed, this.iconColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(right: paddingBtw),
        minimumSize: Size.zero,
        alignment: Alignment.centerLeft,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
        ),
      ),
      icon: iconPath != null ? SvgPicture.asset(
        iconPath,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      ) : null,
    );
  }
}
