import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/search/search_word.dart';
import 'package:guam_community_client/styles/colors.dart';
import '../../commons/sub_headings.dart';
import 'package:guam_community_client/styles/fonts.dart';

class SearchHistory extends StatelessWidget {
  final List<String> sList;

  SearchHistory(this.sList);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        children: [
          SubHeadings(
            '최근 검색어',
            fontSize: 16,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
            fontColor: GuamColorFamily.purpleDark1,
          ),
          Padding(padding: EdgeInsets.only(bottom: 12)),
          Column(
            children: [...sList.map((w) => Padding(
              child: SearchWord(w),
              padding: EdgeInsets.only(bottom: 12),
            ))],
          )
        ],
      ),
    );
  }
}
