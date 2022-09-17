import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_category.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';

class PostDetailBanner extends StatelessWidget {
  final Post? post;

  PostDetailBanner(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (post!.category != null)
              TextButton(
                onPressed: null,
                child: Text(
                  "#" + post!.category!.title!,
                  style: TextStyle(
                    fontSize: 16,
                    color: colorOfCategory(post!.category!.title),
                  ),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: post!.category == null ? 0 : 8),
              child: TextButton(
                onPressed: null,
                child: Text(
                  post!.boardType! + '게시판',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorOfCategory(
                        post!.category != null ? post!.category!.title : '')
                        .withOpacity(0.5),
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
          padding: EdgeInsets.only(top: 8),
          child: Text(post!.title!, style: TextStyle(fontSize: 18)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              CommonImgNickname(
                userId: post!.profile!.id,
                nickname: post!.profile!.nickname,
                profileClickable: post!.profile!.id != 0,
                // 익명 프로필은 프로필 열람 불가
                imgUrl: post!.profile!.profileImg ?? null,
                nicknameColor: GuamColorFamily.grayscaleGray3,
              ),
              Spacer(),
              Text(
                Jiffy(DateTime.parse(post!.createdAt!)).add(hours: 9).format('yyyy.MM.dd  HH:mm'),
                style: TextStyle(
                  fontSize: 12,
                  color: GuamColorFamily.grayscaleGray5,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
