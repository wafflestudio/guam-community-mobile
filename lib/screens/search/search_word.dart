import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/search/search.dart';

class SearchWord extends StatelessWidget {
  final String word;

  SearchWord(this.word);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            word,
            style: TextStyle(
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              fontSize: 14,
              height: 22.4/14,
              color: GuamColorFamily.grayscaleGray2,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        IconText(
          iconSize: 22,
          iconColor: GuamColorFamily.grayscaleGray3,
          iconPath: 'assets/icons/cancel_outlined.svg',
          onPressed: () => context.read<Search>().removeHistory(word),
        )
      ],
    );
  }
}
