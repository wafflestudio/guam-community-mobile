import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:guam_community_client/commons/sub_headings.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../commons/guam_progress_indicator.dart';
import '../../models/boards/post.dart';
import '../../providers/search/search.dart';

class SearchFeed extends StatefulWidget {
  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  List _searchedPosts = [];
  int? _beforePostId;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _showBackToTopButton = false;
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
        _scrollController.position.extentAfter < 600) {
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

  void refreshPost(int idx, Post post) {
    setState(() {
      _searchedPosts.removeAt(idx);
    });
  }

  void _scrollToTop() => _scrollController
      .animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);

  @override
  void initState() {
    _firstLoad();
    _scrollController = ScrollController()..addListener(_loadMore)
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 300) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
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
        : Stack(
            children: [
              RefreshIndicator(
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
                                  '검색결과 ${searchProvider.count}건',
                                  fontColor: GuamColorFamily.grayscaleGray1,
                                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                                  fontSize: 14,
                                ),
                                // SearchFilter(provider: context.read<Search>()),
                              ],
                            ),
                          ),
                          Column(
                            children: [..._searchedPosts.mapIndexed((idx, p) => PostPreview(idx, p, refreshPost))],
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
                ),
              if (_showBackToTopButton)
                Positioned(
                  top: 10,
                  right: 10,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: _scrollToTop,
                    backgroundColor: GuamColorFamily.purpleLight1,
                    child: Icon(Icons.arrow_upward, size: 20, color: GuamColorFamily.grayscaleWhite),
                  ),
                ),
            ],
          );
  }
}