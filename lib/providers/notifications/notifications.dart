import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/notification.dart' as Notification;

import '../../helpers/decode_ko.dart';
import '../user_auth/authenticate.dart';

class Notifications extends ChangeNotifier with Toast {
  bool loading = false;
  bool? _hasNext;
  late Authenticate _authProvider;
  List<Notification.Notification>? _notifications;
  List<Notification.Notification>? _newNotifications;

  Notifications(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchNotifications();
  }

  bool? get hasNext => _hasNext;
  List<Notification.Notification>? get notifications => _notifications;
  List<Notification.Notification>? get newNotifications => _newNotifications;

  Future fetchNotifications({int page=0, int size=20}) async {
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          path: "community/api/v1/push",
          queryParams: {
            "page": page.toString(),
            "size": size.toString(),
          },
          authToken: await _authProvider.getFirebaseIdToken(),
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
            _hasNext = json.decode(jsonUtf8)["hasNext"];
            _notifications = jsonList.map((e) => Notification.Notification.fromJson(e)).toList();

            loading = false;
          } else {
            String msg = '서버가 알림을 불러올 수 없습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = '정보를 모두 입력해주세요.'; break;
              case 401: msg = '열람 권한이 없습니다.'; break;
            }
            showToast(success: false, msg: msg);
          }
        });
        loading = false;
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  /// For Pagination in NotificationBody Widget using _loadMore()
  Future addNotifications({int page=1, int size=20}) async {
    loading = true;
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/push",
        queryParams: {
          "page": page.toString(),
          "size": size.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newNotifications = jsonList.map((e) => Notification.Notification.fromJson(e)).toList();

          loading = false;
        } else {
          // final jsonUtf8 = decodeKo(response);
          // final String? err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: '더 이상 알림을 불러올 수 없습니다.');
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _newNotifications;
  }

  Future readNotifications({int? userId, List? pushEventIds}) async {
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: "community/api/v1/push/read",
          body: {
            "userId": userId.toString(),
            "pushEventIds": pushEventIds,
          },
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            loading = false;
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = '정보를 모두 입력해주세요.'; break;
              case 401: msg = '열람 권한이 없습니다.'; break;
              case 404: msg = '존재하지 않는 알림입니다.'; break;
            }
            showToast(success: false, msg: msg);
          }
        });
        loading = false;
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
