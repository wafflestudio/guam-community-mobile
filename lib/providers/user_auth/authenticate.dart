import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import 'dart:convert';

import '../../models/boards/post.dart';

class Authenticate extends ChangeNotifier with Toast {
  final _kakaoNativeKey = dotenv.env['kakaoNativeKey'];
  final _kakaoJSKey = dotenv.env['kakaoJSKey'];

  FirebaseAuth auth = FirebaseAuth.instance;
  get kakaoNativeKey => _kakaoNativeKey;
  get kakaoJSKey => _kakaoJSKey;

  int? _unRead;
  Profile? me;
  Profile? user;
  List<Profile>? _blockedUsers;
  List<Post>? _myPosts;
  List<Post>? _newMyPosts;
  List<Post>? _scrappedPosts;
  List<Post>? _newScrappedPosts;
  bool? _hasNext;
  bool loading = true;
  bool initialLoading = false;

  Authenticate() {
    initialLoading = true;
    notifyListeners();
    getMyProfile();
  }

  int? get unRead => _unRead;
  bool? get hasNext => _hasNext;
  List<Profile>? get blockedUsers => _blockedUsers;
  List<Post>? get myPosts => _myPosts;
  List<Post>? get newMyPosts => _newMyPosts;
  List<Post>? get scrappedPosts => _scrappedPosts;
  List<Post>? get newScrappedPosts => _newScrappedPosts;
  bool userSignedIn() => auth.currentUser != null; // 로그인 된 유저 존재 여부
  bool profileExists() => me != null && me!.profileSet!; // 프로필까지 만든 정상 유저인지 여부
  bool isMe(int? userId) => me!.id == userId;

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future kakaoSignIn(String? kakaoAccessToken) async {
    try {
      loading = true;
      await HttpRequest().get(
        authority: HttpRequest().immigrationAuthority,
        path: "/api/v1/user/token",
        queryParams: {"kakaoToken": kakaoAccessToken},
      ).then((response) async {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "카카오 로그인 성공!");
          loading = false;
          final customToken = jsonDecode(response.body)['customToken'];
          await auth.signInWithCustomToken(customToken);
          await getMyProfile();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String? err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } on FirebaseAuthException {
      showToast(success: false, msg: "Firebase 인증에 문제가 발생했습니다.");
    } catch (e) {
      showToast(success: false, msg: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future googleSignIn(UserCredential userCredential) async {
    try {
      loading = true;
      showToast(success: true, msg: "구글 로그인 성공!");
      await getMyProfile();
      loading = false;
    } on FirebaseAuthException {
      showToast(success: false, msg: "Firebase 인증에 문제가 발생했습니다.");
    } catch (e) {
      showToast(success: false, msg: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future appleSignIn(UserCredential userCredential) async {
    try {
      loading = true;
      showToast(success: true, msg: "애플 로그인 성공!");
      await getMyProfile();
      loading = false;
    } on FirebaseAuthException {
      showToast(success: false, msg: "Firebase 인증에 문제가 발생했습니다.");
    } catch (e) {
      showToast(success: false, msg: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<String> getFirebaseIdToken() async {
    String idToken;
    try {
      User user = auth.currentUser!;
      idToken = await user.getIdToken();
    } on NoSuchMethodError {
      throw new Exception("로그인이 필요합니다.");
    } catch (e) {
      throw new Exception(e);
    }
    return idToken;
  }

  Future<void> signOut() async {
    loading = false;
    me = null;
    await auth.signOut();
    showToast(success: true, msg: "다시 만나요!");
    notifyListeners();
  }

  Future<bool> deleteUser() async {
    loading = false;
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().delete(
          path: "community/api/v1/users/${me!.id}",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            successful = true;
            showToast(success: true, msg: "계정을 삭제했습니다.");

            // Firebase user 삭제 -> auth.currentUser가 null이 되어 userSignedIn() == false;
            try {
              await auth.currentUser?.delete();
            } on FirebaseException catch (e) {
              if (e.code == 'requires-recent-login') {
                print('The user must reauthenticate before this operation can be executed.');
              }
            } catch (e) {
              print('$e');
            }
          } else {
            final jsonUtf8 = decodeKo(response);
            final String? err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
    }
    notifyListeners();
    return successful;
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
            showToast(success: false, msg: "서버로부터 유저 정보를 불러올 수 없습니다.");
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      initialLoading = false;
      notifyListeners();
    }
  }

  Future setProfile({Map<String, dynamic>? fields, dynamic files, bool updateImage=false}) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().patch(
          path: "community/api/v1/users/${me!.id}",
          body: fields,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8);

            /// S3 Presigned Urls
            if (updateImage) {
              List<dynamic> presignedUrls = [jsonData['presignedUrl']];
              if (presignedUrls.isNotEmpty) {
                await HttpRequest().put(
                  presignedUrls: presignedUrls,
                  files: files,
                ).then((response) async {
                  await getMyProfile();
                });
              }
            } else {
              await getMyProfile();
            }
            successful = true;
            showToast(success: true, msg: "프로필을 설정했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String? err = json.decode(jsonUtf8)["message"];
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

  Future<Profile?> getUserProfile(int? userId) async {
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
            final String? err = json.decode(jsonUtf8)["message"];
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

  Future<bool> setInterest({Map<String, dynamic>? body}) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: "community/api/v1/users/${me!.id}/interest",
          body: body,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "관심사를 등록했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String? err = json.decode(jsonUtf8)["message"];
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
          path: "community/api/v1/users/${me!.id}/interest",
          queryParams: queryParams,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            await getMyProfile();
            successful = true;
            showToast(success: true, msg: "해당 관심사를 삭제했습니다.");
          } else {
            final jsonUtf8 = decodeKo(response);
            final String? err = json.decode(jsonUtf8)["message"];
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

  Future<List<Profile>?> fetchBlockedUsers() async {
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().get(
          path: "community/api/v1/blocks",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["blockUsers"];
            _blockedUsers = jsonList.map((e) => Profile.fromJson(e)).toList();
          } else {
            final jsonUtf8 = decodeKo(response);
            final String? err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _blockedUsers;
  }

  Future<bool> blockUser(blockedUserId) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: "community/api/v1/blocks",
          body: {"blockUserId": blockedUserId.toString()},
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
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

  Future<bool> deleteBlockedUser(blockedUserId) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().delete(
          path: "community/api/v1/blocks",
          body: {"blockUserId": blockedUserId.toString()},
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            successful = true;
            showToast(success: true, msg: "차단을 해제했습니다.");
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 유저입니다."; break;
              case 409: msg = "이미 차단 해제된 유저입니다."; break;
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

  Future<bool> reportUser({bool reportPost=true, Map<String, dynamic>? body}) async {
    bool successful = false;
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: reportPost
              ? "community/api/v1/posts/report"
              : "community/api/v1/comments/report",
          body: body,
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            successful = true;
            showToast(success: true, msg: "해당 사용자를 신고했습니다.");
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = "권한이 없습니다."; break;
              case 404: msg = "존재하지 않는 유저입니다."; break;
              case 409: msg = "이미 신고한 유저입니다."; break;
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

  Future fetchMyPosts({int? userId}) async {
    loading = true;
    try {
      String authToken = await getFirebaseIdToken();
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/users/${me!.id}/my",
        authToken: authToken,
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _myPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
          switch (response.statusCode) {
            case 401: msg = '열람 권한이 없습니다.'; break;
            case 404: msg = '잘못된 유저 정보입니다.'; break;
          }
          showToast(success: false, msg: msg);
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _myPosts;
  }

  /// For Pagination in MyPosts Widget using _loadMore()
  Future addMyPosts({int? beforePostId}) async {
    loading = true;
    try {
      String authToken = await getFirebaseIdToken();
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/users/${me!.id}/my",
        queryParams: {
          "beforePostId": beforePostId.toString(),
        },
        authToken: authToken,
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newMyPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          // final jsonUtf8 = decodeKo(response);
          // final String? err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: '더 이상 글을 불러올 수 없습니다.');
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _newMyPosts;
  }

  Future fetchScrappedPosts({int? userId}) async {
    loading = true;
    try {
      String authToken = await getFirebaseIdToken();
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/users/${me!.id}/scrapped",
        authToken: authToken,
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _scrappedPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
          switch (response.statusCode) {
            case 401: msg = '열람 권한이 없습니다.'; break;
            case 404: msg = '잘못된 유저 정보입니다.'; break;
          }
          showToast(success: false, msg: msg);
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _scrappedPosts;
  }

  /// For Pagination in ScrappedPosts Widget using _loadMore()
  Future addScrappedPosts({int page=1}) async {
    loading = true;
    try {
      String authToken = await getFirebaseIdToken();
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/users/${me!.id}/scrapped",
        queryParams: {
          "page": page.toString(),
        },
        authToken: authToken,
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newScrappedPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          // final jsonUtf8 = decodeKo(response);
          // final String? err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: '더 이상 글을 불러올 수 없습니다.');
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _newScrappedPosts;
  }

  Future<int?> countMsg() async {
    loading = true;
    try {
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/letters/me",
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            _unRead = json.decode(jsonUtf8)["unRead"];
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = '접근 권한이 없습니다.'; break;
            }
            showToast(success: false, msg: msg);
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
    return _unRead;
  }
}
