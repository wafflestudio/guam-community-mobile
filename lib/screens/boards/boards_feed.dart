import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/guam_progress_indicator.dart';
import 'package:guam_community_client/screens/boards/posts/post_list.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/providers/posts/posts.dart';

import '../../models/boards/post.dart';

class BoardsFeed extends StatefulWidget {
  final int? boardId;

  BoardsFeed({this.boardId});

  @override
  State<BoardsFeed> createState() => _BoardsFeedState();
}

class _BoardsFeedState extends State<BoardsFeed> {
  List? _posts = [];
  int? _beforePostId;
  int _rankFrom = 0;
  bool _isSorted = false;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  sortPosts(String filter) {
    setState(() {
      _isSorted = filter == '추천순' ? true : false;
      _firstLoad();
    });
    return _isSorted;
  }

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      if (!_isSorted) {
        // 시간순 정렬
        await context.read<Posts>().fetchPosts(widget.boardId);
        _posts = context.read<Posts>().posts;
      } else {
        // 좋아요순 정렬
        await context.read<Posts>().fetchFavoritePosts(boardId: widget.boardId, rankFrom: _rankFrom);
        _posts = context.read<Posts>().favoritePosts;
      }
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
      _beforePostId = _posts!.last.id;
      _rankFrom += 20;
      try {
        final fetchedPosts = _isSorted
            ? await context.read<Posts>().addFavoritePosts(boardId: widget.boardId, rankFrom: _rankFrom)
            : await context.read<Posts>().addPosts(boardId: widget.boardId, beforePostId: _beforePostId);
        if (fetchedPosts != null && fetchedPosts.length > 0) {
          setState(() => _posts!.addAll(fetchedPosts));
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print('알 수 없는 오류가 발생했습니다.');
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  void refreshPost(int idx, Post refreshedPost) {
    setState(() {
      _posts!.elementAt(idx).commentCount = refreshedPost.commentCount;
      _posts!.elementAt(idx).isLiked = refreshedPost.isLiked;
      _posts!.elementAt(idx).likeCount = refreshedPost.likeCount;
      _posts!.elementAt(idx).isScrapped = refreshedPost.isScrapped;
      _posts!.elementAt(idx).scrapCount = refreshedPost.scrapCount;
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
          if (_scrollController.offset >= 600) {
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
                        PostList(_posts as List<Post>?, refreshPost, sortPosts, _isSorted),
                        if (_isLoadMoreRunning == true)
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 40),
                            child: guamProgressIndicator(size: 40),
                          ),
                        if (_hasNextPage == false && _posts!.length > 10)
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
