import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../styles/colors.dart';

class CreateProjectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: () {
            // 프로젝트 생성 페이지로 이동
          },
          backgroundColor: GuamColorFamily.purpleCore,
          child: SvgPicture.asset(
            'assets/icons/plus.svg',
            color: GuamColorFamily.grayscaleWhite,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}