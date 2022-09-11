import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';

class Next extends StatelessWidget {
  final Function onPressed;

  Next({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('assets/icons/right.svg'),
      onPressed: onPressed as void Function()?,
      color: GuamColorFamily.grayscaleGray5,
    );
  }
}
