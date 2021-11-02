import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class IconText extends StatelessWidget {
  final double size;
  final String text;
  final String iconPath;
  final Function onPressed;
  final HexColor iconHexColor;
  final HexColor textHexColor;

  IconText({this.size=20, this.text, this.iconPath, this.onPressed, this.iconHexColor, this.textHexColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(50, 30),
          alignment: Alignment.centerLeft,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            color: textHexColor,
          ),
        ),
        icon: SvgPicture.asset(
          iconPath,
          color: iconHexColor,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
