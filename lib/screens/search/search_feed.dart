import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/sub_headings.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';
import 'package:guam_community_client/screens/search/search_filter.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../commons/guam_progress_indicator.dart';
import '../../providers/search/search.dart';

class SearchFeed extends StatefulWidget {
  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  List _searchedPosts = [];
  int _beforePostId;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  ScrollController _scrollController = ScrollController();

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      _searchedPosts = context.read<Search>().searchedPosts;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() => _isLoadMoreRunning = true);
      _beforePostId = _searchedPosts.last.id;
      try {
        final fetchedPosts = await context.read<Search>().addSearchedPosts(
          beforePostId: _beforePostId,
        );
        if (fetchedPosts != null && fetchedPosts.length > 0) {
          setState(() => _searchedPosts.addAll(fetchedPosts));
        } else {
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print('알 수 없는 오류가 발생했습니다.');
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  @override
  void initState() {
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<Search>();

    return _isFirstLoadRunning
        ? Center(child: guamProgressIndicator())
        : RefreshIndicator(
            color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
            onRefresh: () async => _firstLoad(),
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadings(
                            /// TODO: commit 전에 검색결과 바꿀 것!
                            '검색결과 ${searchProvider.searchedPosts.length}건',
                            fontColor: GuamColorFamily.grayscaleGray1,
                            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                            fontSize: 14,
                          ),
                          // SearchFilter(provider: context.read<Search>()),
                        ],
                      ),
                    ),
                    Column(
                      children: [..._searchedPosts.map((p) => PostPreview(p))],
                    ),
                    if (_isLoadMoreRunning == true)
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: guamProgressIndicator(size: 40),
                      ),
                    if (_hasNextPage == false && _searchedPosts.length > 10)
                      Container(
                        color: GuamColorFamily.purpleLight2,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(child: Text(
                          '모든 게시글을 불러왔습니다!',
                          style: TextStyle(
                            fontSize: 13,
                            color: GuamColorFamily.grayscaleGray2,
                            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                          ),
                        )),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}