import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/boards/posts/post_list.dart';

class BoardsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PostList()
    );
  }
}
