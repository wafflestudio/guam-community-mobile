import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:guam_community_client/mixins/toast.dart';
import 'package:guam_community_client/models/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../user_auth/authenticate.dart';
import '../../models/boards/post.dart';

class Search extends ChangeNotifier with Toast {
  Authenticate _authProvider;
  bool loading = false;
  bool _hasNext;
  int _count;
  String _searchedKeyword;
  List<Post> _searchedPosts = [];
  List<Post> _newSearchedPosts;

  bool historyFull() => history.length >= maxNHistory;
  List<String> history = [];  // Recently searched word is at the back
  static const String searchHistoryKey = 'search-history';
  static const int maxNHistory = 5;

  int get count => _count;
  String get searchedKeyword => _searchedKeyword;
  List<Post> get searchedPosts => _searchedPosts;
  List<Post> get newSearchedPosts => _newSearchedPosts;
  bool get hasNext => _hasNext;

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

  Future getHistory() async {
    await SharedPreferences.getInstance()
        .then((storage) => history = storage.getStringList(searchHistoryKey) ?? []);
  }

  Future saveHistory(String word) async {
    try {
      if (word.trim() == '' || word.length < 2) return;
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
        _searchedPosts.clear();
        return;
      }
      if (query.length < 2) {
        showToast(success: false, msg: '두 글자 이상 입력해주세요.');
        loading = false;
        return;
      }
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/search",
        queryParams: {"keyword": query},
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          await countSearch(query);

          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _searchedPosts = jsonList.map((e) => Post.fromJson(e)).toList();
          _searchedKeyword = query;
          loading = false;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
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

  /// For Pagination in SearchFeed Widget using _loadMore()
  Future addSearchedPosts({int beforePostId}) async {
    try {
      await HttpRequest()
          .get(
        path: "community/api/v1/posts/search",
        queryParams: {
          "keyword": _searchedKeyword,
          "beforePostId": beforePostId.toString(),
        },
        authToken: await _authProvider.getFirebaseIdToken(),
      ).then((response) async {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["content"];
          _hasNext = json.decode(jsonUtf8)["hasNext"];
          _newSearchedPosts = jsonList.map((e) => Post.fromJson(e)).toList();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          // showToast(success: false, msg: '검색된 게시글을 모두 불러왔습니다.');
        }
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
    return _newSearchedPosts;
  }

  Future<int> countSearch(String query) async {
    loading = true;
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest()
            .get(
          authToken: authToken,
          path: "community/api/v1/posts/search/count",
          queryParams: {"keyword": query},
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            _count = json.decode(jsonUtf8);
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
    return _count;
  }

  void sortSearchedPosts(Filter f) {
    _searchedPosts.sort((a, b) => b.toJson()[f.key].compareTo(a.toJson()[f.key]));
    notifyListeners();
  }
}