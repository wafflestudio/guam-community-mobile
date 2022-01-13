import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';


// ScaleTransition(
// scale: _setAnimation(begin, end),
// child: Container(
// width: width,
// height: height,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: SvgProvider(
// 'assets/backgrounds/splash/star_splash.svg',
// color: color,
// ),
// ),
// )
// )
// ),

class SplashText extends StatefulWidget {
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
    return ScaleTransition(
      scale: CurvedAnimation(
          parent: _animationController,
          curve: Interval(1/100, 1, curve: Curves.fastOutSlowIn)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'IT인들의 커뮤니티',
                style: TextStyle(
                  fontSize: 18,
                  color: GuamColorFamily.grayscaleWhite,
                )
            ),
            Text(
                'Guam',
                style: TextStyle(
                  fontSize: 56,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: GuamColorFamily.purpleDark1,
                )
            )
          ],
        ),
      ),
    );
  }
}
