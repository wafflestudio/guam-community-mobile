import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../mixins/toast.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import '../login/login_button.dart';


class AppleLogin extends StatefulWidget {
  final Function setLoading;

  AppleLogin(this.setLoading);

  @override
  State<AppleLogin> createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> with Toast {
  late Authenticate authProvider;

  @override
  void initState() {
    authProvider = context.read<Authenticate>();
    super.initState();
  }

  Future<UserCredential> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  _loginWithApple() async {
    try {
      widget.setLoading(true);

      final UserCredential? _userCredential = await signInWithApple();
      if (_userCredential != null) {
        await authProvider.appleSignIn(_userCredential);
      } else {
        widget.setLoading(false);
      }
    } catch (e) {
      widget.setLoading(false);
      print(e);
    } finally {
      widget.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      'apple_logo',
      'Sign in with Apple',
      GuamColorFamily.grayscaleGray1,
      GuamColorFamily.grayscaleWhite,
          () => _loginWithApple(),
    );
  }
}
