import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/app/splash/splash_screen.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './screens/user_auth/auth.dart';

void main() async {
  // Returns an instance of the WidgetsBinding, creating and initializing it if necessary.
  // WidgetsBinding provides interaction w/ Flutter Engine.
  WidgetsFlutterBinding.ensureInitialized();

  // Use platform channels to call native code to initialize Firebase.
  // Thus, 'async' main() and placed next to ensureInitialized()
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Future.delayed(Duration(milliseconds: 1500)),
      // 개발시에 주석처리하면 hot reload 시 초기화 안시킬 수 있음.
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            routes: {
              '/': (context) => SplashScreen(),
            },
          ); // 초기 로딩 시 Splash Screen
        } else if (snapshot.hasError) {
          return MaterialApp(home: ErrorScreen()); // 초기 로딩 에러 시 Error Screen
        } else {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<Authenticate>(create: (_) => Authenticate()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => Auth(),
              },
              theme: ThemeData(
                primaryColor: GuamColorFamily.purpleCore,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
              ),
            )
          );
        }
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Error Page");
  }
}
