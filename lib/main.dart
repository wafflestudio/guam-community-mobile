import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/login/signup/signup.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/app/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authenticate>(create: (_) => Authenticate()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          // '/': (context) => SignUp(),
          '/': (context) => App(),
        },
        theme: ThemeData(
          primaryColor: GuamColorFamily.purpleCore,
          fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
        ),
      )
    );
  }
}
