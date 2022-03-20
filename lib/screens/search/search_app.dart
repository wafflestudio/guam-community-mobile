import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/search/search_feed.dart';
import 'package:guam_community_client/screens/search/search_history.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import 'search_app_bar.dart';
import 'search_app_textfield.dart';
import '../../providers/search/search.dart';

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.watch<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Search(authProvider)),
      ],
      child: SearchAppScaffold(),
    );
  }
}

class SearchAppScaffold extends StatefulWidget {
  @override
  State<SearchAppScaffold> createState() => _SearchAppScaffoldState();
}

class _SearchAppScaffoldState extends State<SearchAppScaffold> {
  bool showHistory = true;

  void showSearchHistory(bool) {
    setState(() => showHistory = bool);
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<Search>();

    return Scaffold(
      backgroundColor: GuamColorFamily.purpleLight3,
      appBar: SearchAppBar(
        title: SearchAppTextField(showHistory, showSearchHistory),
      ),
      body: Container(
          width: double.infinity,
          child: searchProvider.searchedPosts.isEmpty
              ? showHistory
                ? SearchHistory(
                    searchList: [...searchProvider.history.reversed],
                      showSearchHistory: showSearchHistory,
                    )
                : Center(child: Text('검색 결과가 없습니다.', style: TextStyle(fontSize: 16)))
              : showHistory
                ? SearchHistory(
                    searchList: [...searchProvider.history.reversed],
                    showSearchHistory: showSearchHistory,
                  )
                : SearchFeed()
      ),
    );
  }
}