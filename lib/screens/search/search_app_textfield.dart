import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../commons/common_text_button.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../providers/search/search.dart';

class SearchAppTextField extends StatefulWidget {
  final bool showHistory;
  final Function showSearchHistory;

  SearchAppTextField(this.showHistory, this.showSearchHistory);

  @override
  State<StatefulWidget> createState() => SearchAppTextFieldState();
}

class SearchAppTextFieldState extends State<SearchAppTextField> {
  static final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<Search>();
    bool isTextEmpty = controller.text == '';

    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              maxLines: 1,
              autofocus: false,
              controller: controller,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.search,
              cursorColor: GuamColorFamily.purpleCore,
              style: TextStyle(
                fontSize: 14,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray1,
                height: 22/14,
              ),
              decoration: InputDecoration(
                hintText: "검색어를 입력해주세요.",
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: GuamColorFamily.purpleCore,
                  size: 20,
                ),
                suffixIcon: !isTextEmpty
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () => controller.clear(),
                        icon: SvgPicture.asset(
                          'assets/icons/cancel_filled_x_transparent.svg',
                          color: GuamColorFamily.grayscaleGray6,
                          width: 18,
                          height: 18,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: GuamColorFamily.purpleLight2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: GuamColorFamily.purpleLight2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: GuamColorFamily.purpleCore),
                ),
              ),
              onSubmitted: (word) {
                searchProvider.searchPosts(query: word, context: context);
                widget.showSearchHistory(false); // 검색 시 히스토리 안보여줌.
                searchProvider.saveHistory(word);
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 4)),
          // '취소' 키 누르면 'x'키 및 '취소' 키 사라짐.
          if (!isTextEmpty || searchProvider.searchedPosts.isNotEmpty)
            CommonTextButton(
              text: '취소',
              fontSize: 14,
              textColor: GuamColorFamily.purpleCore,
              onPressed: () {
                widget.showSearchHistory(true); // 취소하면 history 보여줌.
                FocusScope.of(context).unfocus();
                controller.clear();
              }
            ),
        ],
      ),
    );
  }
}