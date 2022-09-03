import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';


class PostFilter extends StatefulWidget {
  final Function sortPosts;
  final bool isSorted;

  PostFilter(this.sortPosts, this.isSorted);

  @override
  State<StatefulWidget> createState() => PostFilterState();
}

class PostFilterState extends State<PostFilter> {
  String filter;
  static List<String> filters = ['시간순', '추천순'];

  @override
  void initState() {
    filter = widget.isSorted ? filters.last : filters.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...filters.map((f) => CommonTextButton(
        text: f,
        fontSize: 14,
        fontFamily: filter == f ? GuamFontFamily.SpoqaHanSansNeoMedium : GuamFontFamily.SpoqaHanSansNeoRegular,
        textColor: filter == f ? GuamColorFamily.purpleDark1 : GuamColorFamily.grayscaleGray4,
        onPressed: () {
          setState(() {
            filter = f;
            widget.sortPosts(filter);
          });
        })),
      ],
    );
  }
}
