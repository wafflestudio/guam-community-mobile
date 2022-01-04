import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_default.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/screens/boards/comments/comments.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_banner.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_body.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail(this.post);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final int maxRenderImgCnt = 4;
  bool commentImageExist = false;

  void addCommentImage() {
    setState(() => commentImageExist = true);
  }

  void removeCommentImage() {
    setState(() => commentImageExist = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  backgroundColor: GuamColorFamily.grayscaleWhite,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  ),
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 24, top: 24, bottom: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!widget.post.isAuthor)
                            BottomModalDefault(
                              text: '쪽지 보내기',
                              onPressed: (){},
                            ),
                          BottomModalDefault(
                            text: widget.post.isAuthor ? '수정하기' : '신고하기',
                            onPressed: (){},
                          ),
                          BottomModalDefault(
                            text: widget.post.isAuthor ? '삭제하기' : '차단하기',
                            onPressed: (){},
                          ),
                        ],
                      ),
                    ),
                  )
                )
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ...widget.post.comments.map((comment) => Comments(comment: comment))
                    ]
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.black.withOpacity(0.3),
        child: CommonTextField(
          onTap: null,
          addCommentImage: addCommentImage,
          removeCommentImage: removeCommentImage,
          editTarget: null,
        ),
      ),
    );
  }
}
