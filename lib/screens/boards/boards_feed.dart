import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/boards/posts/post_list.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/providers/posts/posts.dart';

class BoardsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PostList(context.read<Posts>().posts)
    );
  }
}
