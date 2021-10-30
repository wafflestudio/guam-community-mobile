import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../../mixins/toast.dart';

class Authenticate extends ChangeNotifier with Toast {
  // final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  // final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  // FirebaseAuth auth = FirebaseAuth.instance;
  // Profile me;
  // bool loading = false;
  //
  // get kakaoClientId => _kakaoClientId;
  //
  // get kakaoJavascriptClientId => _kakaoJavascriptClientId;
  //
  // Authenticate() {
  //   getMyProfile();
  // }
  //
  // bool userSignedIn() => auth.currentUser != null && me != null; // 로그인 된 유저 존재 여부
  // bool profileExists() => me != null && me.isProfileSet; // 프로필까지 만든 정상 유저인지 여부
  //
  // Future kakaoSignIn(String kakaoAccessToken) async {
  //   try {
  //     await HttpRequest().get(
  //       path: "/kakao",
  //       queryParams: {"token": kakaoAccessToken},
  //     ).then((response) async {
  //       if (response.statusCode == 200) {
  //         final customToken = jsonDecode(response.body)["customToken"];
  //         await auth.signInWithCustomToken(customToken);
  //         await getMyProfile();
  //         showToast(success: true, msg: "카카오 로그인 되었습니다.");
  //       } else {
  //         final jsonUtf8 = decodeKo(response);
  //         final String err = json.decode(jsonUtf8)["message"];
  //         showToast(success: false, msg: err);
  //       }
  //     });
  //   } on FirebaseAuthException {
  //     showToast(success: false, msg: "Firebase Auth 에 문제가 발생했습니다.");
  //   } catch (e) {
  //     showToast(success: false, msg: e.message);
  //   } finally {
  //     notifyListeners();
  //   }
  // }
  //
  // Future<String> getFirebaseIdToken() async {
  //   String idToken;
  //
  //   try {
  //     User user = auth.currentUser;
  //     idToken = await user.getIdToken();
  //   } on NoSuchMethodError {
  //     throw new Exception("로그인이 필요합니다.");
  //   } catch (e) {
  //     throw new Exception(e);
  //   }
  //
  //   return idToken;
  // }
  //
  // Future getMyProfile() async {
  //   try {
  //     String authToken = await getFirebaseIdToken();
  //
  //     if (authToken.isNotEmpty) {
  //       await HttpRequest()
  //           .get(
  //         path: "/user/me",
  //         authToken: authToken,
  //       ).then((response) async {
  //         if (response.statusCode == 200) {
  //           final jsonUtf8 = decodeKo(response);
  //           final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
  //           me = Profile.fromJson(jsonData);
  //           setMyFcmToken();
  //         } else {
  //           final jsonUtf8 = decodeKo(response);
  //           final String err = json.decode(jsonUtf8)["message"];
  //           showToast(success: false, msg: err);
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future setProfile({Map<String, dynamic> fields, dynamic files}) async {
  //   bool res = false;
  //
  //   try {
  //     toggleLoading();
  //     String authToken = await getFirebaseIdToken();
  //
  //     if (authToken.isNotEmpty) {
  //       await HttpRequest()
  //           .postMultipart(
  //           path: "/user",
  //           fields: { "command" : "${json.encode(fields)}" },
  //           files: files,
  //           authToken: authToken)
  //           .then((response) async {
  //         if (response.statusCode == 200) {
  //           await getMyProfile();
  //           showToast(success: true, msg: "프로필을 생성하였습니다.");
  //           res = true;
  //         } else {
  //           response.stream.bytesToString().then((val) {
  //             final String err = json.decode(val)["message"];
  //             showToast(success: false, msg: err);
  //           });
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     toggleLoading();
  //   }
  //
  //   return res;
  // }
  //
  // Future<void> signOut() async {
  //   await auth.signOut();
  //   showToast(success: true, msg: "로그아웃 되었습니다.");
  //   notifyListeners();
  // }
  //
  // Future<Profile> getUserProfile(int userId) async {
  //   Profile user;
  //
  //   try {
  //     await HttpRequest()
  //         .get(
  //       path: "/user/$userId",
  //     ).then((response) {
  //       if (response.statusCode == 200) {
  //         final jsonUtf8 = decodeKo(response);
  //         final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
  //         user = Profile.fromJson(jsonData);
  //       } else{
  //         final jsonUtf8 = decodeKo(response);
  //         final String err = json.decode(jsonUtf8)["message"];
  //         showToast(success: false, msg: err);
  //       }
  //     });
  //
  //     return user;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }
  //
  // Future<void> setMyFcmToken() async {
  //   // Disk storage "setFcmToken" will be null at startup, granted bool value afterwords.
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool setFcmToken = prefs.getBool("setFcmToken") ?? false;
  //
  //   if (setFcmToken) return; // No need to set fcm token twice.
  //
  //   try {
  //     String authToken = await getFirebaseIdToken();
  //     String fcmToken = await FirebaseMessaging.instance.getToken();
  //
  //     await HttpRequest().post(
  //         path: "/user/fcm",
  //         authToken: authToken,
  //         body: { "fcmToken": fcmToken }
  //     ).then((response) async {
  //       if (response.statusCode == 200) {
  //         await prefs.setBool("setFcmToken", true);
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // void toggleLoading() {
  //   loading = !loading;
  //   notifyListeners();
  // }
}
