import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:provider/provider.dart';

import '../../../commons/common_text_button.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class ProjectSearchTextField extends StatefulWidget {
  final Map filter;
  final FocusNode focusNode;
  final Function cancelSearch;

  ProjectSearchTextField({
    required this.filter,
    required this.focusNode,
    required this.cancelSearch,
  });

  @override
  State<StatefulWidget> createState() => SearchAppTextFieldState();
}

class SearchAppTextFieldState extends State<ProjectSearchTextField> {
  static final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recruitProvider = context.read<Recruit>();
    bool isTextEmpty = controller.text.trim() == '';

    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              focusNode: widget.focusNode,
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
                  onPressed: () {
                    controller.clear();
                    isTextEmpty = true;
                  },
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
              onChanged: (e) => isTextEmpty = controller.text.trim() == '',
              onSubmitted: (word) {
                if (!isTextEmpty) {
                  recruitProvider.searchProjects(keyword: word, skill: widget.filter['skill'], due: widget.filter['due'], position: widget.filter['position']);
                  widget.cancelSearch(false);
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 4)),
          if (!isTextEmpty || recruitProvider.searchedProjects.isNotEmpty)
            CommonTextButton(
                text: '취소',
                fontSize: 14,
                textColor: GuamColorFamily.purpleCore,
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
        ],
      ),
    );
  }
}