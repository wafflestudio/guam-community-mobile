import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart';
import '../profiles/profiles.dart';

class Messages with ChangeNotifier {
  List<MessageBox> _messageBoxes;
  List<Message> _messages;
  bool loading = false;

  Messages({@required String authToken}) {
    fetchMessageBoxes(authToken);
    fetchMessages(authToken);
  }

  List<MessageBox> get messageBoxes => _messageBoxes;
  List<Message> get messages => _messages;

  Future fetchMessageBoxes(String authToken) async {
    try {
      loading = true;

      List<Map<String, dynamic>> messageBoxes = [
        {
          'id': 1,
          'otherProfile': profiles[6],
          'lastContent': '안녕하세요!',
          'createdAt': DateTime.now().subtract(const Duration(minutes: 8)),
        },
        {
          'id': 2,
          'otherProfile': profiles[5],
          'lastContent': '사용하시는 기술 스택 관련하여 질문이 있습니다!\n저도 플러터를 공부하고 싶은데 혹시 주로 공부하시는 교재나 강의가 있으신가요?',
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
      ];
      _messageBoxes = messageBoxes.map((e) => MessageBox.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future fetchMessages(String authToken) async {
    try {
      loading = true;

      List<Map<String, dynamic>> messages = [
        {
          'id': 1,
          'profile': profiles[7],
          'content': '',
          'picture': {
            'id': 1,
            'urlPath': 'http://img.danawa.com/prod_img/500000/030/472/img/4472030_1.jpg?shrink=330:330&_v=20160923121953',
          },
          'createdAt': DateTime.now().subtract(const Duration(minutes: 8)),
        },
        {
          'id': 2,
          'profile': profiles[5],
          'content': '안녕하세요',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 6)),
        },
        {
          'id': 3,
          'profile': profiles[7],
          'content': '답장',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 3)),
        },
        {
          'id': 4,
          'profile': profiles[5],
          'content': '사용하시는 기술 스택 관련하여 질문이 있습니다!\n저도 플러터를 공부하고 싶은데 혹시 주로 공부하시는 교재나 강의가 있으신가요?',
          'picture': null,
          'createdAt': DateTime.now().subtract(const Duration(minutes: 1)),
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
