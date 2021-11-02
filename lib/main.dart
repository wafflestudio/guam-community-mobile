import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/home/root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static HexColor themeColor = HexColor('#6951FF');

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
            '/': (context) => Root(),
          },
          theme: ThemeData(
            primaryColor: themeColor,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
          ),
        )
    );
  }
}
