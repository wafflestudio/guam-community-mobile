import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/color_of_category.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
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
                onPressed: () {},
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
                onPressed: () {},
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
            )
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 8),
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: post.profile.profileImg.urlPath != null
                        ? NetworkImage(post.profile.profileImg.urlPath)
                        : SvgProvider('assets/icons/profile_image.svg'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                post.profile.nickname,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray3,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                DateFormat('yyyy.MM.dd  HH:mm').format(post.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray5,
                ),
              ),
            ),
          ],
        ),
      ]
    );
  }
}
