import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/screens/search/search_word.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../commons/sub_headings.dart';
import 'package:guam_community_client/styles/fonts.dart';

class SearchHistory extends StatelessWidget {
  final List<String>? searchList;
  final Function? showSearchHistory;

  SearchHistory({this.searchList, this.showSearchHistory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDivider(color: GuamColorFamily.grayscaleGray7),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(color: GuamColorFamily.grayscaleGray8),
          child: SubHeadings(
            '최근 검색어',
            fontSize: 14,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
            fontColor: GuamColorFamily.grayscaleGray4,
          ),
        ),
        CustomDivider(color: GuamColorFamily.grayscaleGray7),
        if (searchList!.isNotEmpty)
          Container(
            color: GuamColorFamily.grayscaleWhite,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              children: [...searchList!.map((w) => Padding(
                child: SearchWord(w, showSearchHistory),
                padding: EdgeInsets.only(bottom: 16),
              ))],
            ),
          ),
      ],
    );
  }
}