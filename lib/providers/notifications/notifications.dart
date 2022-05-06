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
  bool _hasNext;
  Authenticate _authProvider;
  List<Notification.Notification> _notifications;
  List<Notification.Notification> _newNotifications;

  Notifications(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchNotifications();
  }

  bool get hasNext => _hasNext;
  List<Notification.Notification> get notifications => _notifications;
  List<Notification.Notification> get newNotifications => _newNotifications;

  Future fetchNotifications() async {
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          path: "community/api/v1/push",
          authToken: await _authProvider.getFirebaseIdToken(),
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
            // _hasNext = json.decode(jsonUtf8)["hasNext"];
            _notifications = jsonList.map((e) => Notification.Notification.fromJson(e)).toList();

            loading = false;
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.';
            switch (response.statusCode) {
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
}
