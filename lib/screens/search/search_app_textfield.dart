import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../commons/common_text_button.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../../providers/search/search.dart';
import '../../providers/user_auth/authenticate.dart';

class SearchAppTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchAppTextFieldState();
}

class SearchAppTextFieldState extends State<SearchAppTextField> {
  static final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.read<Search>();
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: TextField(
                controller: controller,
                autofocus: false,
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray1,
                  height: 22/14,
                ),
                cursorColor: GuamColorFamily.purpleCore,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: GuamColorFamily.grayscaleGray3,
                    size: 16,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  filled: true,
                  fillColor: GuamColorFamily.grayscaleGray6,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                onSubmitted: (word) {
                  searchProvider.searchPosts(
                    authToken: context.read<Authenticate>().authToken,
                    query: word
                  );
                  searchProvider.saveHistory(word);
                  FocusScope.of(context).unfocus();
                },
              )
          ),
          Padding(padding: EdgeInsets.only(right: 4)),
          CommonTextButton(
            text: '취소',
            fontSize: 14,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            textColor: GuamColorFamily.purpleCore,
            onPressed: () => controller.clear()
          )
        ],
      ),
    );
  }
}
