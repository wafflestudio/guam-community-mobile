import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final HexColor? color;

  CustomDivider({
    this.height = 1,
    this.thickness = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      color: color,
    );
  }
}
