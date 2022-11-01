import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class NextButton extends StatelessWidget {
  final int page;
  final bool active;
  final String label;
  final Function onTap;

  NextButton({
    this.page=1,
    this.active=true,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Container(
          height: 56,
          alignment: Alignment.center,
          width: page == 1
              ? MediaQuery.of(context).size.width * 0.9
              : MediaQuery.of(context).size.width * 0.45,
          decoration: BoxDecoration(
            color: active
                ? GuamColorFamily.purpleCore
                : GuamColorFamily.grayscaleGray7,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: active
                  ? GuamColorFamily.grayscaleWhite
                  : GuamColorFamily.grayscaleGray5,
            ),
          ),
        )
      )
    );
  }
}

