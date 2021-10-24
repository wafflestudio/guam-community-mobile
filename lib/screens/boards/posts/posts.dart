import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: HexColor('#6951FF'),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/write.svg',
              color: Colors.white,
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
