import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/search/search.dart';

class SearchFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchFilterState();
}

class SearchFilterState extends State {
  var filter;

  @override
  void initState() {
    filter = Search.filters.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<Search>();

    return Row(
      children: [...Search.filters.map((f) => CommonTextButton(
        text: f.label,
        fontSize: 14,
        fontFamily: filter == f ? GuamFontFamily.SpoqaHanSansNeoMedium : GuamFontFamily.SpoqaHanSansNeoRegular,
        textColor: filter == f ? GuamColorFamily.purpleDark1 : GuamColorFamily.grayscaleGray4,
        onPressed: () {
          setState(() => filter = f);
          searchProvider.sortSearchedPosts(f);
        },
      ))],
    );
  }
}