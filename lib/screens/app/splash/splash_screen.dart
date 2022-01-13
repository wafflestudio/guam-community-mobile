import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/screens/app/splash/splash_text.dart';
import 'package:guam_community_client/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  @override _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _animation = Tween<Offset>(
        begin: Offset(2.0, 0.0),
        end: Offset(0.0, 1.0)
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          1/9,
          1,
          curve: Curves.linear,
        )
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) {
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
                image: AssetImage('assets/backgrounds/back_0.75x.png')
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
                image: AssetImage('assets/backgrounds/front_0.75x.png')
              )
            ),
            child: Stack(
              children: [
                SlideTransition(
                  position: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: SvgProvider('assets/backgrounds/splash/Subtract-3.svg'),
                      ),
                    )
                  )
                ),
                SlideTransition(
                  position: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: SvgProvider('assets/backgrounds/splash/Subtract-2.svg'),
                      ),
                    )
                  )
                ),
                SplashText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
