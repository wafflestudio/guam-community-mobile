import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';

import '../../../commons/guam_progress_indicator.dart';
import '../../../commons/sub_headings.dart';
import '../../../styles/fonts.dart';
import 'post_filter.dart';

class PostList extends StatefulWidget {
  final List<Post> posts;
  final Function refreshPost;
  final Function sortPosts;
  final bool isSorted;
  final bool hasNextPage;
  final bool isLoadMoreRunning;
  final ScrollController scrollController;

  PostList({required this.posts,
    required this.refreshPost,
    required this.sortPosts,
    required this.isSorted ,
    required this.hasNextPage,
    required this.isLoadMoreRunning,
    required this.scrollController});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GuamColorFamily.purpleLight3), // backgrounds color
      child: ListView.builder(
          controller: widget.scrollController,
          itemCount: (widget.isLoadMoreRunning || (!widget.hasNextPage && widget.posts.length > 10))
              ? widget.posts.length + 2 : widget.posts.length + 1,
          itemBuilder: (context, index){
            if(index == 0) return  Padding(
              padding: EdgeInsets.only(top: 24, left: 22, right: 10, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubHeadings("특별한 일이 있나요? ✨"),
                  PostFilter(widget.sortPosts, widget.isSorted),
                ],
              ),
            );
            // index == 0 -> header
            else if(index == widget.posts.length + 1){
              if(widget.isLoadMoreRunning) return Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: guamProgressIndicator(size: 40),
              );
              else return Container(
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
              );
            }
            else if(index == widget.posts.length) return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: PostPreview(index-1, widget.posts[index-1], widget.refreshPost),
            );
            else return PostPreview(index-1, widget.posts[index-1], widget.refreshPost);
          }),
    );
  }
}
