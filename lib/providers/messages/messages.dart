import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart';
import '../../helpers/decode_ko.dart';
import '../user_auth/authenticate.dart';

class Messages extends ChangeNotifier with Toast {
  Authenticate _authProvider;
  List<MessageBox> _messageBoxes;
  List<Message> _messages;
  bool loading = false;

  Messages(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchMessageBoxes();
  }

  List<MessageBox> get messageBoxes => _messageBoxes;
  List<Message> get messages => _messages;

  Future fetchMessageBoxes() async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          path: "community/api/v1/letters/letters",
          authToken: authToken,
        ).then((response) async {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["letterBoxes"];
            _messageBoxes = jsonList.map((e) => MessageBox.fromJson(e)).toList();
            loading = false;
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 400: msg = '메시지를 불러올 수 없습니다.'; break;
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
  Future<List<Message>> getMessages(int otherProfileId) async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/letters/letters/$otherProfileId",
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["letters"];
            _messages = jsonList.map((e) => Message.fromJson(e)).toList();
          } else {
            String msg = '알 수 없는 오류가 발생했습니다.: ${response.statusCode}';
            switch (response.statusCode) {
              case 401: msg = '접근 권한이 없습니다.'; break;
              case 403: msg = '상대방으로부터 차단되었습니다.'; break;
              case 404: msg = '존재하지 않는 쪽지함입니다.'; break;
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
    return _messages;
  }
}
