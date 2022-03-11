import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import 'dart:convert';

class Authenticate with ChangeNotifier {
  final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  FirebaseAuth auth = FirebaseAuth.instance;
  get kakaoClientId => _kakaoClientId;
  get kakaoJavascriptClientId => _kakaoJavascriptClientId;

  Profile me;
  Profile user;
  bool loading = false;

  Authenticate() {
    getMyProfile();
  }

  bool userSignedIn() => auth.currentUser != null && me != null; // 로그인 된 유저 존재 여부
  bool profileExists() => me != null && me.profileSet; // 프로필까지 만든 정상 유저인지 여부

  bool isMe(int userId) => me.id == userId;

  Future kakaoSignIn(String kakaoAccessToken) async {
    try {
      await HttpRequest().get(
        isHttps: false, // TODO: remove after immigration heads to gateway
        authority: HttpRequest().immigrationAuthority,
        path: "/api/v1/auth/token",
        queryParams: {"kakaoToken": kakaoAccessToken},
      ).then((response) async {
        if (response.statusCode == 200) {
          final customToken = jsonDecode(response.body)['customToken'];
          await auth.signInWithCustomToken(customToken);
          await getMyProfile();
          // TODO: show toast after impl. toast
          // showToast(success: true, msg: "카카오 로그인 되었습니다.");
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          // TODO: show toast after impl. toast
          // showToast(success: false, msg: err);
        }
      });
    } on FirebaseAuthException {
      // TODO: show toast after impl. toast
      // showToast(success: false, msg: "Firebase Auth 에 문제가 발생했습니다.");
    } catch (e) {
      // TODO: show toast after impl. toast
      // showToast(success: false, msg: e.message);
    }
  }

  Future<String> getFirebaseIdToken() async {
    String idToken;

    try {
      User user = auth.currentUser;
      idToken = await user.getIdToken();
    } on NoSuchMethodError {
      throw new Exception("로그인이 필요합니다.");
    } catch (e) {
      throw new Exception(e);
    }
    return idToken;
  }

  Future getMyProfile() async {
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
          .get(
            path: "community/api/v1/users/me",
            authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            me = Profile.fromJson(jsonData);
            // TODO: set fcm token when impl. push notification
            // setMyFcmToken();
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            // TODO: show toast after impl. toast
            // showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future setProfile({Map<String, dynamic> body, dynamic files}) async {
    bool res = false;

    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .patch(
            path: "community/api/v1/users/${me.id}",
            body: body,
            authToken: authToken)
          .then((response) async {
            if (response.statusCode == 200) {
              // TODO: delete this line after server response add profileSet property
              await getMyProfile();
              // TODO: uncomment below lines
              final jsonUtf8 = decodeKo(response);
              final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
              me = Profile.fromJson(jsonData);
              print("${me.profileSet}, ${me.nickname}");
              // // showToast(success: true, msg: "프로필을 생성하였습니다.");
              // res = true;
          } else {
              final jsonUtf8 = decodeKo(response);
              final String err = json.decode(jsonUtf8)["message"];
              // TODO: show toast after impl. toast
              // showToast(success: false, msg: err);
            }
          });
        }
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
    }

    return res;
  }

  Future<Profile> getUserProfile(int userId) async {
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          path: "community/api/v1/users/$userId",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            user = Profile.fromJson(jsonData);
            // TODO: set fcm token when impl. push notification
            // setMyFcmToken();
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            // TODO: show toast after impl. toast
            // showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return user;
  }

  Future<bool> setInterest({Map<String, dynamic> body}) async {
    bool successful = false;

    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(
            path: "community/api/v1/users/${me.id}/interest",
            body: body,
            authToken: authToken)
            .then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            // // showToast(success: true, msg: "프로필을 생성하였습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            // TODO: show toast after impl. toast
            // showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
    }
    return successful;
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future<void> signOut() async {
    await auth.signOut();
    // TODO: show toast after impl. toast
    // showToast(success: true, msg: "로그아웃 되었습니다.");
    notifyListeners();
  }
}
