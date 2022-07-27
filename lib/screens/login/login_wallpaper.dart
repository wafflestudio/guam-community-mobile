import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../helpers/svg_provider.dart';
import '../../styles/colors.dart';
import '../app/splash/splash_text.dart';

class LoginWallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              image: AssetImage('assets/backgrounds/back_0.75x.png'),
            ),
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
            ),
          ),
          child: Stack(
            children: [
              // 위에서부터 아래로 star 배치
              _star(
                width: 26, height: 26, // size of star
                top: size.height*0.12, left: size.width*0.24, // position of star (iPhone 13 : 375x812)
                color: GuamColorFamily.purpleDark1,
              ),
              _star(
                width: 32, height: 32,
                top: size.height*0.19, left: size.width*0.88,
                color: GuamColorFamily.purpleCore,
              ),
              _star(
                width: 25, height: 25,
                top: size.height*0.32, left: size.width*0.42,
                color: GuamColorFamily.purpleLight1,
              ),
              _star(
                width: 25, height: 25,
                top: size.height*0.50, left: size.width*0.76,
                color: GuamColorFamily.purpleLight2,
              ),
              _star(
                width: 32, height: 32,
                top: size.height*0.57, left: size.width*0.16,
                color: GuamColorFamily.purpleLight2,
              ),
              _star(
                width: 25, height: 25,
                top: size.height*0.68, left: size.width*0.57,
                color: GuamColorFamily.purpleLight3,
              ),
              SplashText(animation: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _star({double top, double left, double width, double height, HexColor color}){
    return Positioned(
      top: top,
      left: left,
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
        ),
      ),
    );
  }
}
