import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class PreviousButton extends StatelessWidget {
  final int page;
  final Function onTap;

  PreviousButton({required this.page, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
      child: InkWell(
        onTap: onTap as void Function()?,
          child: Container(
            height: 56,
            alignment: Alignment.center,
            width: page == 1
                ? MediaQuery.of(context).size.width * 0.9
                : MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: GuamColorFamily.purpleCore,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              '이전',
              style: TextStyle(
                fontSize: 16,
                color: GuamColorFamily.grayscaleWhite,
              ),
            ),
          )
      ),
    );
  }
}