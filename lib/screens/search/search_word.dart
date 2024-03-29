import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/screens/search/search_app_textfield.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/search/search.dart';

class SearchWord extends StatelessWidget {
  final String word;
  final Function? showSearchHistory;

  SearchWord(this.word, this.showSearchHistory);

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<Search>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            child: Text(
              word,
              style: TextStyle(
                fontSize: 14,
                height: 22.4/14,
                overflow: TextOverflow.ellipsis,
                color: GuamColorFamily.grayscaleGray2,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              ),
            ),
            onTap: () {
              searchProvider.searchPosts(query: word);
              showSearchHistory!(false);
              SearchAppTextFieldState.controller.text = word;
              searchProvider.saveHistory(word);
            },
          ),
        ),
        IconText(
          iconSize: 18,
          iconColor: GuamColorFamily.grayscaleGray6,
          iconPath: 'assets/icons/cancel_filled_x_transparent.svg',
          paddingBtw: 0,
          onPressed: () => searchProvider.removeHistory(word),
        ),
      ],
    );
  }
}