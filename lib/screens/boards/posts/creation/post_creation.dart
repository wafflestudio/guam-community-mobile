import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_board.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_content.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_image.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_interest.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_title.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostCreation extends StatefulWidget {
  @override
  State<PostCreation> createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  Map input = {
    'title': '',
    'content': '',
    'boardType': '',
    'interest': '',
    'images': [],
  };

  bool isBoardAnonymous = false;

  void setBoardAnonymous(String boardType){
    setState(() {
      if (boardType == '익명게시판'){
        isBoardAnonymous = true;
      } else {
        isBoardAnonymous = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        leading: Card(
          elevation: 0,
          color: GuamColorFamily.grayscaleWhite,
          margin: EdgeInsets.zero,
          child: IconButton(
            icon: SvgPicture.asset('assets/icons/back.svg'),
            onPressed: () =>
                showMaterialModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: GuamColorFamily.grayscaleWhite,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
              ),
              builder: (context) =>
                  SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '게시글 작성을 취소하시겠어요?',
                            style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                          ),
                          TextButton(
                            child: Text(
                              '돌아가기',
                              style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                              ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '게시글은 임시저장되지 않습니다.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: GuamColorFamily.grayscaleGray2,
                            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil('/main', (route) => true),
                          child: Text(
                            '취소하기',
                            style: TextStyle(fontSize: 16, color: GuamColorFamily.redCore),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: TextButton(
            onPressed: () {
              print(input);
            },
            style: TextButton.styleFrom(
              minimumSize: Size(30, 26),
              alignment: Alignment.center,
            ),
            child: Text(
              '등록',
              style: TextStyle(
                color: GuamColorFamily.purpleCore,
                fontSize: 16,
              ),
            ),
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: GuamColorFamily.grayscaleWhite,
              padding: EdgeInsets.only(left: 24, top: 10, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostCreationBoard(input, setBoardAnonymous),
                  PostCreationTitle(input),
                  CustomDivider(color: GuamColorFamily.grayscaleGray7),
                  PostCreationContent(input),
                ],
              ),
            ),
            CustomDivider(
              height: 12,
              thickness: 12,
              color: GuamColorFamily.purpleLight3,
            ),
            Container(
              color: GuamColorFamily.grayscaleWhite,
              width: double.infinity,
              padding: EdgeInsets.only(left: 24, top: 20, right: 0, bottom: 42),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostCreationInterest(input, isBoardAnonymous),
                  PostCreationImage(input)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
