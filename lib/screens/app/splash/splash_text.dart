import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';


class SplashText extends StatefulWidget {
  final bool animation;

  SplashText({this.animation=true});

  @override
  State<SplashText> createState() => _SplashTextState();
}

class _SplashTextState extends State<SplashText> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animation) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: _animationController,
          curve: Interval(1 / 100, 1, curve: Curves.fastOutSlowIn),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'IT인들의 커뮤니티',
                style: TextStyle(
                  fontSize: 18,
                  color: GuamColorFamily.purpleLight3,
                ),
              ),
              Text(
                'Guam',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  fontFamily: GuamFontFamily.Poppins,
                  color: GuamColorFamily.purpleDark1,
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'IT인들의 커뮤니티',
              style: TextStyle(
                fontSize: 18,
                color: GuamColorFamily.purpleLight3,
              ),
            ),
            Text(
              'Guam',
              style: TextStyle(
                height: 1.3,
                fontSize: 56,
                fontWeight: FontWeight.w700,
                fontFamily: GuamFontFamily.Poppins,
                color: GuamColorFamily.purpleDark1,
              ),
            )
          ],
        ),
      );
    }
  }
}
