import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_community_client/models/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../user_auth/authenticate.dart';
import '../../models/boards/post.dart';

class Search with ChangeNotifier {
  Authenticate _authProvider;
  List<Post> searchedPosts = [];

  List<String> history = [];  // Recently searched word is at the back
  static const String searchHistoryKey = 'search-history';
  static const int maxNHistory = 5;

  static List<Filter> filters = [
    Filter(
      key: 'createdAt',
      label: '시간순',
    ),
    Filter(
      key: 'like',
      label: '추천순',
    ),
  ];

  Search(Authenticate authProvider) {
    _authProvider = authProvider;
    getHistory();
  }

  bool loading = false;

  bool historyFull() => history.length >= maxNHistory;

  Future getHistory() async {
    await SharedPreferences.getInstance()
        .then((storage) => history = storage.getStringList(searchHistoryKey) ?? []);
  }

  Future saveHistory(String word) async {
    try {
      if (word.trim() == '') return;
      if (historyFull()) history.removeAt(0);
      if (!history.contains(word)) history.add(word);
      await SharedPreferences.getInstance()
          .then((storage) => storage.setStringList(searchHistoryKey, history));
    } catch(e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future removeHistory(String word) async {
    try {
      history.remove(word);
      await SharedPreferences.getInstance()
          .then((storage) => storage.setStringList(searchHistoryKey, history));
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future searchPosts({@required String query, BuildContext context}) async {
    loading = true;
    try {
      if (query == null || query.trim() == '') {
        searchedPosts.clear();
        return;
      }
      await HttpRequest()
          .get(
        path: "community/api/v1/posts",
        queryParams: {"keyword": query},
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          searchedPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          loading = false;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          // TODO: show toast after impl. toast
          // showToast(success: false, msg: err);
        }
      });

      // Default search with first filter
      sortSearchedPosts(filters[0]);
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  void sortSearchedPosts(Filter f) {
    searchedPosts.sort((a, b) => b.toJson()[f.key].compareTo(a.toJson()[f.key]));
    notifyListeners();
  }
}