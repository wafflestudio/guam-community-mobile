import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/login/login_wallpaper.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import 'login_buttons.dart';

class LoginPage extends StatelessWidget {
  @override Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = context.watch<Authenticate>();

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          LoginWallpaper(),
          authProvider.loading
              ? Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height*0.15),
                    child: CircularProgressIndicator(color: GuamColorFamily.purpleCore),
                  ),
                )
              : Positioned(top: size.height*0.7, child: LoginButtons()),
        ],
      ),
    );
  }
}
