// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYoZLtqIgtE8eLeyNgCoLYIa3f3UYmXDs',
    appId: '1:648780047414:android:f3e6e071c18e0e8721a497',
    messagingSenderId: '648780047414',
    projectId: 'waffle-guam',
    storageBucket: 'waffle-guam.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkeKrJihj2WMWtlqWxfzL2aQTtNr-ytTg',
    appId: '1:648780047414:ios:f8612570b75dadb921a497',
    messagingSenderId: '648780047414',
    projectId: 'waffle-guam',
    storageBucket: 'waffle-guam.appspot.com',
    androidClientId: '648780047414-d2fbe0qcdiugckgq8stcqvgef89ie6a9.apps.googleusercontent.com',
    iosClientId: '648780047414-erb4hojdlnk09dk8nvcjjgdps2q3cc8n.apps.googleusercontent.com',
    iosBundleId: 'com.wafflestudio.guam-community',
  );
}
