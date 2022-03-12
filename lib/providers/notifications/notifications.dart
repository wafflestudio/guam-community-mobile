import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/notification.dart' as Notification;

class Notifications with ChangeNotifier {
  List<Notification.Notification> _notifications;
  bool loading = false;

  Notifications({@required String authToken}) {
    fetchNotifications(authToken);
  }

  List<Notification.Notification> get notifications => _notifications;

  Future fetchNotifications(String authToken) async {
    try {
      loading = true;

      List<Map<String, dynamic>> notifications = [
        {
          'id': 1,
          'postId': 3,
          'commentId': null,
          'isRead': true,
          'comment': null,
          'type': 'post_liked',
          'otherProfile': {
            'id': 1,
            'nickname': 'marcelko',
            'profileImg': {
              'id': 1,
              'urlPath': "https://w.namu.la/s/40de86374ddd74756b31d4694a7434ee9398baa51fa5ae72d28f2eeeafdadf0c475c55c58e29a684920e0d6a42602b339f8aaf6d19764b04405a0f8bee7f598d2922db9475579419aac4635d0a71fdb8a4b2343cb550e6ed93e13c1a05cede75",
            },
          },
          'createdAt': DateTime.now().subtract(const Duration(minutes: 0)),
        },
        {
          'id': 2,
          'postId': 3,
          'commentId': 1,
          'isRead': false,
          'comment': '모니터 쓰실거면 13인치 추천합니다~',
          'type': 'commented',
          'otherProfile': {
            'id': 2,
            'nickname': 'jwjeong',
            'profileImg': {
              'id': 2,
              'urlPath': 'https://cdn.speconomy.com/news/photo/201705/20170514_1_bodyimg_82397.png',
            },
          },
          'createdAt': DateTime.now().subtract(const Duration(minutes: 2)),
        },
        {
          'id': 3,
          'postId': 3,
          'commentId': null,
          'isRead': false,
          'comment': null,
          'type': 'scrapped',
          'otherProfile': {
            'id': 2,
            'nickname': 'jwjeong',
            'profileImg': {
              'id': 2,
              'urlPath': 'https://cdn.speconomy.com/news/photo/201705/20170514_1_bodyimg_82397.png',
            },
          },
          'createdAt': DateTime.now().subtract(const Duration(days: 20)),
        },
        {
          'id': 4,
          'postId': 3,
          'commentId': 3,
          'isRead': true,
          'comment': null,
          'type': 'comment_liked',
          'otherProfile': {
            'id': 4,
            'nickname': '맨날비와',
            'profileImg': {
              'id': 4,
              'urlPath': 'https://t1.daumcdn.net/cfile/tistory/99A97E4C5D25E9C226',
            },
          },
          'createdAt': DateTime.now().subtract(const Duration(days: 200)),
        },
      ];

      _notifications = notifications.map((e) => Notification.Notification.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
