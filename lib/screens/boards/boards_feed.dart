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
  @override
  void initState() {
    context.read<Posts>().fetchPosts(widget.boardId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return context.watch<Posts>().loading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(child: PostList(context.read<Posts>().posts));
  }
}
