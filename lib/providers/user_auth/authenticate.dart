import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import 'dart:convert';

class Authenticate extends ChangeNotifier with Toast {
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

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

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
          showToast(success: true, msg: "카카오 로그인 성공!");
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } on FirebaseAuthException {
      showToast(success: false, msg: "Firebase 인증에 문제가 발생했습니다.");
    } catch (e) {
      showToast(success: false, msg: e.message);
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

  Future<void> signOut() async {
    await auth.signOut();
    showToast(success: true, msg: "로그아웃 되었습니다.");
    notifyListeners();
  }

  Future getMyProfile() async {
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().get(
          path: "community/api/v1/users/me",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);
            me = Profile.fromJson(jsonData);
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future setProfile({Map<String, dynamic> fields, dynamic files}) async {
    bool successful = false;

    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().patchMultipart(
          path: "community/api/v1/users/${me.id}",
          fields: fields,
          files: files,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "프로필을 설정했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
      notifyListeners();
    }
    return successful;
  }

  Future<Profile> getUserProfile(int userId) async {
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().get(
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
            showToast(success: false, msg: err);
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
        await HttpRequest().post(
          path: "community/api/v1/users/${me.id}/interest",
          body: body,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "관심사를 등록했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
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

  Future<bool> deleteInterest({dynamic queryParams}) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().delete(
          path: "community/api/v1/users/${me.id}/interest",
          queryParams: queryParams,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "해당 관심사를 삭제했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
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

  Future<bool> blockUser({userId}) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: "community/api/v1/block",
          queryParams: {"targetId": userId.toString()},
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "해당 사용자를 차단했습니다.");
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 유저입니다."; break;
              case 409: msg = "이미 차단한 유저입니다."; break;
            }
            showToast(success: false, msg: msg);
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
}
