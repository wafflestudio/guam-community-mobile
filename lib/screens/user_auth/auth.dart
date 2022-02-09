import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home/home_provider.dart';
import '../app/app.dart';
import '../login/login_page.dart';
import '../../providers/user_auth/authenticate.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<Authenticate>();

    return authProvider.userSignedIn()
        ? ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            child: App(),
          )
        : LoginPage();
  }
}
