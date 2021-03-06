import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';

import '../../../commons/sub_headings.dart';
import '../../search/search_filter.dart';

class PostList extends StatefulWidget {
  final List<Post> posts;
  final Function refreshPost;

  PostList(this.posts, this.refreshPost);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GuamColorFamily.purpleLight3), // backgrounds color
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24, left: 22, right: 10, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubHeadings("특별한 일이 있나요? ✨"),
                /// TODO: 추천순 API 완성되면 붙이기.
                // SearchFilter(provider: context.read<Posts>()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [...widget.posts.mapIndexed((idx, post) => PostPreview(idx, post, widget.refreshPost))]
            ),
          ),
        ],
      ),
    );
  }
}
