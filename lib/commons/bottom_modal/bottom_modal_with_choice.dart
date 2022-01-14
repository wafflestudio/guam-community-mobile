import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import '../custom_divider.dart';

class BottomModalWithChoice extends StatefulWidget {
  final String func;
  final String title;
  final String back;
  final String body;
  final String selectedChoice;
  final Function choiceFunc;

  BottomModalWithChoice({this.func, this.title, this.back, this.body, this.selectedChoice, this.choiceFunc});

  @override
  State<BottomModalWithChoice> createState() => _BottomModalWithChoiceState();
}

class _BottomModalWithChoiceState extends State<BottomModalWithChoice> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                ),
                TextButton(
                  child: Text(
                    widget.back,
                    style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(30, 26),
                    alignment: Alignment.centerRight,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            CustomDivider(color: GuamColorFamily.grayscaleGray7),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: [
                  _boardType('익명게시판'),
                  _boardType('자유게시판'),
                  _boardType('구인게시판'),
                  _boardType('정보공유게시판'),
                  _boardType('홍보게시판'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boardType(String boardType) {
    return Builder(
        builder: (context) => InkWell(
          onTap: () {
            widget.choiceFunc(boardType);
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  child: Text(
                    boardType,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                      color: boardType == widget.selectedChoice
                          ? GuamColorFamily.purpleCore
                          : GuamColorFamily.grayscaleGray3,
                    ),
                  ),
                ),
                if (boardType == widget.selectedChoice)
                  IconButton(
                    padding: EdgeInsets.only(right: 8),
                    constraints: BoxConstraints(),
                    icon: SvgPicture.asset('assets/icons/check.svg'),
                    onPressed: null,
                  ),
              ],
            ),
          ),
        )
    );
  }
}
