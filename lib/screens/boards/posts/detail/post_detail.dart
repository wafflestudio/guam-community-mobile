import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/screens/boards/comments/comments.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_banner.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_body.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_more.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail(this.post);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final int maxRenderImgCnt = 4;
  bool commentImageExist = false;
  List<Map<String, dynamic>> mentionList = [];
  Set<int> mentionListId = {};
  List<Map<String, dynamic>> result = [];

  @override
  void initState() {
    mentionList = [widget.post.profile.toJson()];
    mentionListId = {widget.post.profile.id};
    super.initState();
  }

  void addCommentImage() {
    setState(() => commentImageExist = true);
  }

  void removeCommentImage() {
    setState(() => commentImageExist = false);
  }

  @override
  void dispose() {
    mentionList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Scaffold(
        backgroundColor: GuamColorFamily.grayscaleWhite,
        appBar: CustomAppBar(
          leading: Back(),
          trailing: Padding(
            padding: EdgeInsets.only(right: 11),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/scrap_outlined.svg'),
                  onPressed: () {},
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  icon: SvgPicture.asset('assets/icons/more.svg'),
                  onPressed: () => showMaterialModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) => PostDetailMore(widget.post),
                    backgroundColor: GuamColorFamily.grayscaleWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: commentImageExist ? 156 : 56,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostDetailBanner(widget.post),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 20),
                  child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
                ),
                PostDetailBody(widget.post),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 8),
                  child: PostInfo(
                    post: widget.post,
                    iconSize: 24,
                    showProfile: false,
                    iconColor: GuamColorFamily.grayscaleGray4,
                  ),
                ),
                CustomDivider(color: GuamColorFamily.grayscaleGray7),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: FutureBuilder(
                    future: context.read<Posts>().fetchComments(widget.post.id),
                    builder: (_, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isNotEmpty) {
                          // 댓글에서 중복을 허용하지 않도록 멘션 가능한 프로필 추출
                          Future.delayed(
                            Duration.zero,
                            () => setState(() => snapshot.data.forEach((e) {
                              if (!mentionListId.contains(e.profile.id))
                                mentionList.add(e.profile.toJson());
                              mentionListId.add(e.profile.id);
                            }))
                          );
                          return Column(
                            children: [
                              ...snapshot.data.map(
                                      (comment) => Comments(comment: comment))
                            ]
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: Center(
                              child: Text(
                                "작성된 댓글이 없습니다.",
                                style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray5),
                              ),
                            )
                          );
                        }
                      } else if (snapshot.hasError) {
                        /// TODO: 에러 메시지 띄워주기
                        return Center(child: CircularProgressIndicator());
                      } else {
                        /// API 통신 중...
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          color: Colors.black.withOpacity(0.3),
          child: CommonTextField(
            onTap: null,
            mentionList: mentionList,
            addCommentImage: addCommentImage,
            removeCommentImage: removeCommentImage,
            editTarget: null,
          ),
        ),
      ),
    );
  }
}
