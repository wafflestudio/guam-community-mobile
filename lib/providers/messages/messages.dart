import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/helpers/http_request.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart';
import '../../helpers/decode_ko.dart';
import '../user_auth/authenticate.dart';
import '../user_auth/profile_data.dart';

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

  Future fetchMessages(int messageBoxNo) async {
    try {
      loading = true;

      List<Map<String, dynamic>> messages = [
        {
          'id': 1,
          'profile': profiles[7],
          'isMe': false,
          'content': '',
          'picture': {
            'id': 1,
            'urlPath': 'https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75',
          },
          'createdAt': DateTime.now().subtract(const Duration(minutes: 8)),
        },
        {
          'id': 2,
          'profile': profiles[5],
          'isMe': true,
          'content': '안녕하세요',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 6)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 4,
          'profile': profiles[5],
          'isMe': true,
          'content': '사용하시는 기술 스택 관련하여 질문이 있습니다!\n저도 플러터를 공부하고 싶은데 혹시 주로 공부하시는 교재나 강의가 있으신가요?',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 1)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },{
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'isMe': false,
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },

      ];
      _messages = messages.map((e) => Message.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
