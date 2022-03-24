import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';

import '../../../commons/sub_headings.dart';
import '../../search/search_filter.dart';

class PostList extends StatefulWidget {
  final List<Post> posts;

  PostList(this.posts);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<String> selectedCategories = [];

  void setCategory(String category){
    setState(() => selectedCategories.contains(category)
        ? selectedCategories.remove(category)
        : selectedCategories.add(category)
    );
  }

  @override
  void initState() {
    selectedCategories = ['#개발', '#데이터분석', '#디자인', '#기획/마케팅', '#기타'];
    super.initState();
  }

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
                SearchFilter(provider: context.read<Posts>()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [...widget.posts.map((post) => PostPreview(post))]
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryType(StateSetter myState, String category) {
    return Builder(
      builder: (_) => InkWell(
        onTap: () =>
          myState(() => selectedCategories.contains(category)
              ? selectedCategories.remove(category)
              : selectedCategories.add(category)
          ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 26,
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: selectedCategories.contains(category)
                        ? GuamColorFamily.purpleCore
                        : GuamColorFamily.grayscaleGray3,
                  )
                )
              ),
              if (selectedCategories.contains(category))
                IconButton(
                  onPressed: null,
                  padding: EdgeInsets.only(right: 8),
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/check.svg'),
                ),
            ],
          ),
        ),
      )
    );
  }
}
