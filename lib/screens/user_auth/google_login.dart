import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import '../login/login_button.dart';


class GoogleLogin extends StatefulWidget {
  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  Authenticate authProvider;

  @override
  void initState() {
    authProvider = context.read<Authenticate>();
    super.initState();
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  _loginWithGoogle() async {
    try {
      authProvider.loading = true;

      final _userCredential = await _signInWithGoogle();
      await authProvider.googleSignIn(_userCredential);
    } catch (e) {
      print(e);
    } finally {
      authProvider.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      'google_logo',
      '구글로 시작하기',
      GuamColorFamily.grayscaleWhite,
      () => _loginWithGoogle(),
    );
  }
}
