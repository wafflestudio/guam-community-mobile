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
      widget.setLoading(true);

      final _userCredential = await _signInWithGoogle();
      await authProvider.googleSignIn(_userCredential);
    } catch (e) {
      widget.setLoading(false);
      showToast(success: false, msg: '일시적인 오류로 인해\n카카오 로그인을 이용해주세요.');
      print(e);
    } finally {
      widget.setLoading(false);
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
