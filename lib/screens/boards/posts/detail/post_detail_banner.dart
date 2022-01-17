import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_interest.dart';
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
            TextButton(
              onPressed: () {},
              child: Text(
                "#" + post.interest,
                style: TextStyle(
                  fontSize: 16,
                  color: colorOfInterest(post.interest),
                ),
              ),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.only(top: 24),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  post.boardType,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorOfInterest(post.interest),
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
            )
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              CommonImgNickname(
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
