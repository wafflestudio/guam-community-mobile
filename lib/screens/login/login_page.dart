import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/screens/login/login_wallpaper.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import 'login_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Toast {
  Future userLoggedIn;

  @override
  void initState() {
    userLoggedIn = Future.delayed(
      Duration(milliseconds: 1000),
          () async => context.read<Authenticate>().profileExists(),
    );
    super.initState();
  }

  @override Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = context.watch<Authenticate>();

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          LoginWallpaper(),
          FutureBuilder(
            future: userLoggedIn,
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Positioned(top: size.height*0.72, child: LoginButtons());
              } else if (snapshot.hasError) {
                showToast(success: false, msg: '일시적인 오류입니다. \n잠시 후 다시 시도해주세요.');
                return null;
              } else {
                return authProvider.loading ? Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height*0.15),
                    child: CircularProgressIndicator(color: GuamColorFamily.purpleCore),
                  ),
                ) : Positioned(top: size.height*0.72, child: LoginButtons());
              }
            },
          ),
        ],
      ),
    );
  }
}
