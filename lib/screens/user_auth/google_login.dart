import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../mixins/toast.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import '../login/login_button.dart';


class GoogleLogin extends StatefulWidget {
  final Function setLoading;

  GoogleLogin(this.setLoading);

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> with Toast {
  late Authenticate authProvider;

  @override
  void initState() {
    authProvider = context.read<Authenticate>();
    super.initState();
  }

  Future<UserCredential?> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = (await googleUser.authentication);

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return null;
    }
  }

  _loginWithGoogle() async {
    try {
      widget.setLoading(true);

      final UserCredential? _userCredential = await _signInWithGoogle();
      if (_userCredential != null) {
        await authProvider.googleSignIn(_userCredential);
      } else {
        widget.setLoading(false);
      }
    } catch (e) {
      widget.setLoading(false);
      // showToast(success: false, msg: '일시적인 오류로 인해\n다른 소셜 로그인을 이용해주세요.');
      print(e);
    } finally {
      widget.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      'google_logo',
      'Sign in with Google',
      GuamColorFamily.grayscaleWhite,
      GuamColorFamily.grayscaleGray1,
      () => _loginWithGoogle(),
    );
  }
}
