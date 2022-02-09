import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import '../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';

class KakaoLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return KakaoLoginState();
  }
}

class KakaoLoginState extends State<KakaoLogin> {
  Authenticate authProvider;
  bool _isKakaoTalkInstalled;

  @override
  void initState() {
    authProvider = context.read<Authenticate>();
    KakaoContext.clientId = authProvider.kakaoClientId;
    KakaoContext.javascriptClientId = authProvider.kakaoJavascriptClientId;
    _initKakaoTalkInstalled();
    super.initState();
  }

  void _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() => _isKakaoTalkInstalled = installed);
  }

  _issueAccessToken(String authCode) async {
    try {
      final token = await AuthApi.instance.issueAccessToken(authCode);
      final tokenManager = new DefaultTokenManager();
      tokenManager.setToken(token); // Store access token in TokenManager for future API requests.
      return token;
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  * Kakao login via browser
  */
  _loginWithKakao() async {
    try {
      authProvider.toggleLoading();

      final authCode = await AuthCodeClient.instance.request();
      final token = await _issueAccessToken(authCode);
      await authProvider.kakaoSignIn(token.accessToken);
    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      print(e);
    } finally {
      authProvider.toggleLoading();
    }
  }

  /*
  * Kakao login via KakaoTalk
  */
  _loginWithTalk() async {
    try {
      authProvider.toggleLoading();

      final authCode = await AuthCodeClient.instance.requestWithTalk();
      final token = await _issueAccessToken(authCode);
      await authProvider.kakaoSignIn(token.accessToken);
    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      print(e);
    } finally {
      authProvider.toggleLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
  return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image(
          image: AssetImage("assets/buttons/kakao_login_large_narrow.png"),
        ),
      ),
      onTap: () => _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao(),
    );
  }
}
