import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/common_text_field.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/screens/boards/comments/comments.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_banner.dart';
import 'package:guam_community_client/screens/boards/posts/detail/post_detail_body.dart';
import 'package:guam_community_client/screens/boards/posts/post_info.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostDetail extends StatelessWidget {
  final int maxRenderImgCnt = 4;
  final Post post;

  PostDetail(this.post);

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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, bottom: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostDetailBanner(post),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 20),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: GuamColorFamily.grayscaleGray7,
                ),
              ),
              PostDetailBody(post),
              Padding(
                padding: EdgeInsets.only(top: 14, bottom: 8),
                child: PostInfo(
                  post: post,
                  iconSize: 24,
                  showProfile: false,
                  iconColor: GuamColorFamily.grayscaleGray4,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: GuamColorFamily.grayscaleGray7,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ...post.comments.map((comment) => Comments(comment: comment))
                    ]
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 56,
        child: CommonTextField(onTap: null, editTarget: null),
      ),
    );
  }
}
