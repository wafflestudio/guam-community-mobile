import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_board.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_content.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_image.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_category.dart';
import 'package:guam_community_client/screens/boards/posts/creation/post_creation_title.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../commons/functions_category_boardType.dart';
import '../../../../providers/posts/posts.dart';

class PostCreation extends StatefulWidget {
  final bool isEdit;
  final dynamic editTarget;

  PostCreation({this.isEdit = false, this.editTarget});

  @override
  State<PostCreation> createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> {
  Map input = {};
  bool isBoardAnonymous = false;
  bool isNewPost = true;
  bool requesting = false;

  void toggleRequest() {
    setState(() => requesting = !requesting);
  }

  Future createOrUpdatePost({List<File> files}) async {
    toggleRequest();
    Map<String, dynamic> fields = {
      'title': input['title'],
      'content': input['content'],
      'boardId': input['boardId'],
      'tagId': input['tagId'],
    };
    try {
      if (isNewPost) {
        return await context.read<Posts>().createPost(
          fields: fields,
          files: files,
        ).then((successful) {
          if (successful) {
            context.read<Posts>().fetchPosts(0);
            Navigator.pop(context);
            return successful;
          }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleRequest();
    }
  }

  @override
  void initState() {
    if (widget.editTarget != null) {
      input = {
        'title': widget.editTarget.title,
        'content': widget.editTarget.content,
        'boardType': widget.editTarget.boardType,
        'boardId': transferBoardType(widget.editTarget.boardType),
        'category': widget.editTarget.category,
        'tagId': transferCategory(widget.editTarget.category),
        /// TODO: 이미지는 기존 게시글 이미지 S3 주소 받아와서 처리할 예정
      };
    } else {
      input = {
        'title': '',
        'content': '',
        'boardId': '',
        'boardType': '',
        'tagId': '',
        'category': '',
        'images': [],
      };
    }
    super.initState();
  }

  void setBoardAnonymous(String boardType) {
    setState(() => boardType == '익명'
        ? isBoardAnonymous = true
        : isBoardAnonymous = false
    );
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
            onPressed: () => showMaterialModalBottomSheet(
              context: context,
              useRootNavigator: true,
              backgroundColor: GuamColorFamily.grayscaleWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '게시글 ${widget.isEdit ? '수정': '작성'}을 취소하시겠어요?',
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
                          widget.isEdit
                              ? '수정된 내용이 사라집니다.'
                              : '게시글은 임시저장되지 않습니다.',
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
                          onPressed: () {
                            if (widget.isEdit) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main', (route) => true
                              );
                            }
                          },
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
            onPressed: !requesting
                ? () async {
              await createOrUpdatePost(
                  files: (input['images'] != [])
                      ? [...input['images'].map((e) => File(e.path))]
                      : []
              );
            } : null,
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
                  // if (!isBoardAnonymous)
                  PostCreationCategory(input),
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
