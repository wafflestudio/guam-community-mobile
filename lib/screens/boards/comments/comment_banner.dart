import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class CommentBanner extends StatelessWidget {
  final Comment comment;

  CommentBanner(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: comment.profile.profileImageUrl != null
                    ? NetworkImage(comment.profile.profileImageUrl)
                    : SvgProvider('assets/icons/profile_image.svg'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              comment.profile.nickname,
              style: TextStyle(
                fontSize: 12,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                color: GuamColorFamily.grayscaleGray3,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              'assets/icons/more.svg',
              color: GuamColorFamily.grayscaleGray5,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
