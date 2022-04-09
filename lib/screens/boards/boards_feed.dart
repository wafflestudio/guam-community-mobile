import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/boards/posts/post_list.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/providers/posts/posts.dart';

class BoardsFeed extends StatefulWidget {
  final int boardId;

  BoardsFeed({this.boardId});

  @override
  State<BoardsFeed> createState() => _BoardsFeedState();
}

class _BoardsFeedState extends State<BoardsFeed> {
  final ScrollController _scrollController = ScrollController();
  bool turnPage = false;

  void addPosts() {
    int beforePostId = context.read<Posts>().posts.last.id;
    if (turnPage)
      Future.delayed(Duration.zero, () async {
      context.read<Posts>().addPosts(
          boardId: widget.boardId,
          beforePostId: beforePostId,
        );
      });
  }

  @override
  void initState() {
    context.read<Posts>().fetchPosts(widget.boardId);

    _scrollController.addListener(() {
      turnPage = _scrollController.offset / _scrollController.position.maxScrollExtent >= 0.5;
      if (turnPage && context.read<Posts>().hasNext) addPosts();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<Posts>().loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => context.read<Posts>().fetchPosts(widget.boardId),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: PostList(context.read<Posts>().posts),
            ),
        );
  }
}
