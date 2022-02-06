import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import './profile_data.dart' as profile;

class Authenticate with ChangeNotifier {
  var _authToken;
  final storage = FlutterSecureStorage();

  Profile me;
  bool loading = false;

  get authToken => _authToken;
  set authToken(token) {
    _authToken = token;
    notifyListeners();
  }

  Authenticate() {
    initAuthToken();
    getMyProfile(authToken);
  }

  bool isMe(int userId) => me.id == userId;

  void initAuthToken() async {
    await storage
        .read(key: 'authentication_token')
        .then((value) => this.authToken = value)
        .catchError((error) {print(error);});
  }

  Future saveAuthToken(String authToken) async {
    this.authToken = authToken;
    await storage.write(key: 'authentication_token', value: authToken);
  }

  Future destroyAuthToken() async {
    this.authToken = null;
    await storage.delete(key: 'authentication_token');
  }

  /* 유저 로그인/회원가입 서버 개발 전 임시방편 코드
  Future signIn({Map<String, dynamic> params}) async {
    await HttpRequest()
        .post(partialUrl: "sign_in", body: params)
        .then((response) => saveAuthToken(json.decode(response.body)['authentication_token']));
  }
  */
  //유저 로그인/회원가입 서버 개발 전 임시방편 코드
  Future signIn({Map<String, dynamic> params}) async {
    List<dynamic> tempUsers = [
      { "email": "gajagajago@naver.com", "password": "1234" },
      { "email": "khko", "password": "123456" },
    ];
    print(params);

    var valid = tempUsers.any((e) => e['email'] == params['email'] && e['password'] == params['password']);

    if (valid) {
      await Future.delayed(const Duration(milliseconds: 100), () => 'temp_auth_blah_blah')
          .then((response) => saveAuthToken(response));
    } else {
      throw Exception('No valid user');
    }
  }

  // Future signUp({Map<String, dynamic> params}) async {
  //   await HttpRequest()
  //       .post(partialUrl: "sign_up", body: params)
  //       .then((response) => saveAuthToken(json.decode(response.body)['authentication_token']));
  // }
  /*
  Future signOut({String authToken}) async {
    await HttpRequest()
        .delete(partialUrl: "sign_out", authToken: authToken)
        .then((response) => response);
  }
  */
  // 유저 로그인/회원가입 서버 개발 전 임시방편 코드
  // Future signOut({String authToken}) async {
  //   await Future.delayed(const Duration(milliseconds: 100), () => '')
  //       .then((response) => saveAuthToken(response));
  // }

  Future getMyProfile(String authToken) async {
    loading = true;

    try {
      Map<String, dynamic> jsonData = profile.profiles[2];
      me = Profile.fromJson(jsonData);

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future<Profile> getUserProfile(int userId) async {
    loading = true;
    Profile user;

    try {
      if (userId == null) return null;
      // API 붙일 때는 (idx - 1) 방식 대신 직접 userId를 넘길 예정.
      Map<String, dynamic> jsonData = profile.profiles[userId-1];
      user = Profile.fromJson(jsonData);

      loading = false;

      return user;
    } catch (e) {
      print(e);
      return  null;
    } finally {
      notifyListeners();
    }
  }
}
