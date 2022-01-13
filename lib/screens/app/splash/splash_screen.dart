import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/screens/app/splash/splash_text.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatefulWidget {
  @override _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  AnimationController _animationController;

  _setAnimation(double begin, double end){
    return CurvedAnimation(
      parent: _animationController,
      curve: Interval(begin, end, curve: Curves.fastOutSlowIn)
    );
  }

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

  @override Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/backgrounds/back_0.75x.png'),
              )
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/backgrounds/front_0.75x.png'),
              )
            ),
            child: Stack(
              children: [
                // 위에서부터 아래로 star 배치
                _starSplash(
                  begin: 1/4, end: 1, // animation
                  width: 26, height: 26, // size of star
                  top: size.height*0.12, left: size.width*0.24, // position of star (iPhone 13 : 375x812)
                  color: GuamColorFamily.purpleDark1,
                ),
                _starSplash(
                  begin: 1/20, end: 1,
                  width: 32, height: 32,
                  top: size.height*0.2, left: size.width*0.88,
                  color: GuamColorFamily.purpleCore,
                ),
                _starSplash(
                  begin: 1/10, end: 1,
                  width: 25, height: 25,
                  top: size.height*0.32, left: size.width*0.42,
                  color: GuamColorFamily.purpleLight1,
                ),
                _starSplash(
                  begin: 1/2, end: 1,
                  width: 25, height: 25,
                  top: size.height*0.45, left: size.width*0.78,
                  color: GuamColorFamily.purpleLight2,
                ),
                _starSplash(
                  begin: 1/2, end: 1,
                  width: 32, height: 32,
                  top: size.height*0.56, left: size.width*0.16,
                  color: GuamColorFamily.purpleLight2,
                ),
                _starSplash(
                  begin: 1/30, end: 1,
                  width: 25, height: 25,
                  top: size.height*0.66, left: size.width*0.57,
                  color: GuamColorFamily.purpleLight3,
                ),
                SplashText(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _starSplash({double top, double left, double width, double height, double begin, double end, HexColor color}){
    return Positioned(
      top: top,
      left: left,
      child: ScaleTransition(
        scale: _setAnimation(begin, end),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: SvgProvider(
                'assets/backgrounds/splash/star_splash.svg',
                color: color,
              ),
            ),
          )
        )
      ),
    );
  }
}
