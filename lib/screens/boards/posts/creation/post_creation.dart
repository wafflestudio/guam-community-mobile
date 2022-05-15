import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/mixins/toast.dart';
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
import '../../../../commons/guam_progress_indicator.dart';
import '../../../../models/boards/post.dart';
import '../../../../providers/posts/posts.dart';
import '../../../../providers/user_auth/authenticate.dart';
import '../detail/post_detail.dart';

class PostCreation extends StatefulWidget {
  final bool isEdit;
  final dynamic editTarget;

  PostCreation({this.isEdit = false, this.editTarget});

  @override
  State<PostCreation> createState() => _PostCreationState();
}

class _PostCreationState extends State<PostCreation> with Toast {
  Map input = {};
  bool isBoardAnonymous = false;

  @override
  void initState() {
    Post editPost = widget.editTarget;
    if (widget.editTarget != null) {
      input = {
        'title': editPost.title,
        'content': editPost.content,
        'boardType': editPost.boardType,
        'boardId': transferBoardType(editPost.boardType),
        'category': editPost.category != null ? editPost.category.title : "",
        'categoryId': editPost.category != null ? editPost.category.categoryId : 0,
        'images': editPost.imagePaths, /// 이미지는 S3 주소 받아와서 그대로 전송 (수정 불가능)
      };
    } else {
      input = {
        'title': '',
        'content': '',
        'boardId': '',
        'boardType': '',
        'categoryId': '',
        'category': '',
        'images': [],
      };
    }
    super.initState();
  }

  Future createOrUpdatePost({List<File> files}) async {
    Posts postProvider = context.read<Posts>();
    Authenticate authProvider = context.read<Authenticate>();

    bool successful = false;
    Map<String, dynamic> fields = {
      'title': input['title'],
      'content': input['content'],
      'boardId': input['boardId'].toString(),
      'categoryId': input['categoryId'].toString(),
    };

    try {
      if (widget.isEdit && widget.editTarget != null) {
        return await postProvider.editPost(
          postId: widget.editTarget.id,
          body: fields,
        ).then((successful) {
          if (successful) {
            Navigator.pop(context, fields);
            successful = true;
          }
        });
      } else {
        return await postProvider.createPost(
          fields: fields,
          files: files,
        ).then((successful) {
          if (successful) {
            Navigator.pop(context);
            postProvider.fetchPosts(0);
            /// 게시글 생성 후 getPost(createdPostId) 하여 새로운 게시글로 이동
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Posts(authProvider)),
                  ],
                  child: FutureBuilder(
                      future: postProvider.getPost(postProvider.createdPostId),
                      builder: (_, AsyncSnapshot<Post> snapshot) {
                        if (snapshot.hasData) {
                          return PostDetail(snapshot.data);
                        } else if (snapshot.hasError) {
                          Navigator.pop(context);
                          postProvider.fetchPosts(0);
                          showToast(success: false, msg: '게시글을 찾을 수 없습니다.');
                          return null;
                        } else {
                          return Center(child: guamProgressIndicator());
                        }
                      }
                  ),
                ),
              ),
            );
            successful = true;
          }
        });
      }
    } catch (e) {
      print(e);
    }
    return successful;
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
                                '/', (route) => false
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
            onPressed: () async {
              await createOrUpdatePost(
                  files: (input['images'] != [] && !widget.isEdit)
                      ? [...input['images'].map((e) => File(e.path))]
                      : []
              );
            },
            style: TextButton.styleFrom(
              minimumSize: Size(30, 26),
              alignment: Alignment.center,
            ),
            child: Text(
              widget.isEdit ? '수정' : '등록',
              style: TextStyle(
                color: GuamColorFamily.purpleCore,
                fontSize: 16,
              ),
            ),
          ),
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
                  PostCreationBoard(input, widget.isEdit, setBoardAnonymous),
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
                  if (!widget.isEdit) PostCreationImage(input)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
