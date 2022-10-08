import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/login/login_wallpaper.dart';
import 'package:guam_community_client/screens/login/signup/signup.dart';
import 'package:provider/provider.dart';
import '../../providers/home/home_provider.dart';
import '../app/app.dart';
import '../login/login_page.dart';
import '../../providers/user_auth/authenticate.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

    return authProvider.initialLoading ? Scaffold(body: LoginWallpaper()) : authProvider.userSignedIn()
        ? authProvider.profileExists()
          ? ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            child: App(),
          )
          : SignUp()
        : LoginPage();
  }
}
