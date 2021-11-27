import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonTextButton extends StatelessWidget {
  final double fontSize;
  final String text;
  final Function onPressed;
  final HexColor textColor;
  final String fontFamily;

  CommonTextButton({this.text, this.fontSize, this.fontFamily, this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: textColor
        ),
      ),
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        alignment: Alignment.centerLeft,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
