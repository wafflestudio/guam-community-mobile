import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class NextButton extends StatelessWidget {
  final String label;
  final Function onTap;

  NextButton({
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
          alignment: Alignment.center,
          height: 56,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: GuamColorFamily.purpleCore,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: GuamColorFamily.grayscaleWhite,
              fontSize: 16,
            ),
          ),
        )
      )
    );
  }
}

