import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../../models/boards/post.dart';

class Posts with ChangeNotifier {
  List<Post> _posts;
  int boardId = 0; // default : 피드게시판
  bool loading = false;

  Posts() {
    fetchPosts(boardId);
  }

  List<Post> get posts => _posts;

  Future fetchPosts(int boardId) async {
    try {
      loading = true;
      await HttpRequest()
          .get(
        path: "community/api/v1/posts",
        queryParams: {"boardId": boardId.toString()},
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _posts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
          // TODO: set fcm token when impl. push notification
          // setMyFcmToken();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          // TODO: show toast after impl. toast
          // showToast(success: false, msg: err);
        }
      });
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
