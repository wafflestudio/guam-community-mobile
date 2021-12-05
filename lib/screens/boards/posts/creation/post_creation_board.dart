import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostCreationBoard extends StatefulWidget {
  final Map input;

  PostCreationBoard(this.input);

  @override
  _PostCreationBoardState createState() => _PostCreationBoardState();
}

class _PostCreationBoardState extends State<PostCreationBoard> {
  @override
  void initState() {
    super.initState();
  }

  void setBoardType(String boardType){
    setState(() => widget.input['boardType'] = boardType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          children: [
            Text(
              widget.input['boardType'] == ''
                  ? '게시판을 선택해주세요.'
                  : widget.input['boardType'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: widget.input['boardType'] == ''
                    ? GuamColorFamily.grayscaleGray3
                    : GuamColorFamily.purpleCore,
              ),
            ),
            IconButton(
              padding: EdgeInsets.only(left: 4),
              constraints: BoxConstraints(),
              icon: SvgPicture.asset(
                'assets/icons/down.svg',
                color: widget.input['boardType'] == ''
                    ? GuamColorFamily.grayscaleGray3
                    : GuamColorFamily.purpleCore,
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(136, 23)),
        onPressed: () => showMaterialModalBottomSheet(
          context: context,
          useRootNavigator: true,
          backgroundColor: GuamColorFamily.grayscaleWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
          ),
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 24, top: 18, right: 18),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '게시판을 선택해주세요.',
                        style: TextStyle(
                          fontSize: 18,
                          color: GuamColorFamily.grayscaleGray2,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          '완료',
                          style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore),
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(30, 26),
                          alignment: Alignment.centerRight,
                        ),
                        onPressed: () => Navigator.pop(context)
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
          )
        )
      )
    );
  }

  Widget _boardType(String boardType) {
    return Builder(
      builder: (context) => InkWell(
        onTap: () {
          setBoardType(boardType);
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
                    color: boardType == widget.input['boardType']
                        ? GuamColorFamily.purpleCore
                        : GuamColorFamily.grayscaleGray3,
                  )
                )
              ),
              if (boardType == widget.input['boardType'])
                IconButton(
                  padding: EdgeInsets.only(right: 8),
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/check.svg'),
                ),
            ],
          ),
        ),
      )
    );
  }
}
