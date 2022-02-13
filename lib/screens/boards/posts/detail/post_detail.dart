import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/commons/custom_divider.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/providers/posts/posts.dart';
import 'package:guam_community_client/providers/user_auth/authenticate.dart';
import 'package:guam_community_client/screens/boards/comments/comments.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_banner.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_body.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_more.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../models/profiles/profile.dart';

class PostDetail extends StatefulWidget {
  final Post post;

  PostDetail(this.post);

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  final int maxRenderImgCnt = 4;
  bool commentImageExist = false;
  Profile myProfile;
  Future<Post> post;

  @override
  void initState() {
    super.initState();
    myProfile = context.read<Authenticate>().me;
    /// 서버 변경 후에는 post 부분은 parent에서 가져다 쓰고,
    /// comment 부분만 따로 API 넣을 예정. (해당 API 제작 요청 상태)
    post = Future.delayed(
      Duration.zero,
          () async => context.read<Posts>().getPost(widget.post.id),
    );
  }

  void addCommentImage() {
    setState(() => commentImageExist = true);
  }

  void removeCommentImage() {
    setState(() => commentImageExist = false);
  }

  @override
  Widget build(BuildContext context) {
    /// comment만 불러오는 API 완성되면, FutureBuilder는
    /// 저 밑에 comment map 하는 부분에 쓰일 예정...
    return FutureBuilder(
      future: post,
      builder: (_, AsyncSnapshot<Post> snapshot) {
        if (snapshot.hasData){
          Post _post = snapshot.data;
          return Scaffold(
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
                        backgroundColor: GuamColorFamily.grayscaleWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )
                        ),
                        builder: (context) => PostDetailMore(
                          post: _post,
                          isMe: _post.profile.id == myProfile.id,
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
                    PostDetailBanner(_post),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 20),
                      child: CustomDivider(color: GuamColorFamily.grayscaleGray7),
                    ),
                    PostDetailBody(_post),
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
                    if (widget.post.comments != null)
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
        } else if (snapshot.hasError) {
          // 에러 메시지 띄워주기
          print("error");
          return Center(child: CircularProgressIndicator());
        } else {
          print(snapshot);
          print("idon know");
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
