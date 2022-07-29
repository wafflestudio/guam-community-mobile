import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:kakao_flutter_sdk/all.dart';
import '../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';
import '../login/login_button.dart';

class KakaoLogin extends StatefulWidget {
  final Function setLoading;

  KakaoLogin(this.setLoading);

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
      widget.setLoading(true);

      final authCode = await AuthCodeClient.instance.request();
      final token = await _issueAccessToken(authCode);
      await authProvider.kakaoSignIn(token.accessToken);

    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      if (e is PlatformException && e.code == 'CANCELED') {
        widget.setLoading(false);
      }
      print(e);
    } finally {
      widget.setLoading(false);
    }
  }

  /*
  * Kakao login via KakaoTalk
  */
  _loginWithTalk() async {
    try {
      widget.setLoading(true);

      final authCode = await AuthCodeClient.instance.requestWithTalk();
      final token = await _issueAccessToken(authCode);
      await authProvider.kakaoSignIn(token.accessToken);
    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      if (e is PlatformException && e.code == 'CANCELED') {
        widget.setLoading(false);
      }
      print(e);
    } finally {
      widget.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      'kakao_logo',
      '카카오로 시작하기',
      GuamColorFamily.kakaoYellow,
      () => _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao()
    );
  }
}
