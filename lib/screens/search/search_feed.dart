import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/sub_headings.dart';
import 'package:guam_community_client/screens/boards/posts/preview/post_preview.dart';
import 'package:guam_community_client/screens/search/search_filter.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/search/search.dart';

class SearchFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<Search>();

    return SingleChildScrollView(
      child: Container(
        color: GuamColorFamily.purpleLight3,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubHeadings(
                    '검색결과 ${searchProvider.searchedPosts.length}건',
                    fontColor: GuamColorFamily.grayscaleGray1,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    fontSize: 14,
                  ),
                  SearchFilter(),
                ],
              ),
            ),
            Column(
              children: [...searchProvider.searchedPosts.map((p) => PostPreview(p))],
            )
          ],
        ),
      ),
    );
  }
}