import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_category.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:intl/intl.dart';

class PostDetailBanner extends StatelessWidget {
  final Post post;

  PostDetailBanner(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (post.category != '')
              TextButton(
                onPressed: null,
                child: Text(
                  "#" + post.category,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorOfCategory(post.category),
                  ),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: post.category == '' ? 0 : 8),
              child: TextButton(
                onPressed: null,
                child: Text(
                  post.boardType,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorOfCategory(post.category).withOpacity(0.5),
                  ),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only( top: 8),
          child: Text(
            post.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              CommonImgNickname(
                userId: post.profile.id,
                imgUrl: post.profile.profileImg != null ? post.profile.profileImg.urlPath : null,
                nickname: post.profile.nickname,
                nicknameColor: GuamColorFamily.grayscaleGray3,
              ),
              Spacer(),
              Text(
                DateFormat('yyyy.MM.dd  HH:mm').format(post.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray5,
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}
