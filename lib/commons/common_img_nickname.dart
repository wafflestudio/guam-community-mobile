import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

class CommonImgNickname extends StatelessWidget {
  final String imgUrl;
  final String nickname;

  CommonImgNickname({this.imgUrl, this.nickname});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8, right: 8),
          child: Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imgUrl != null
                      ? NetworkImage(imgUrl)
                      : SvgProvider('assets/icons/profile_image.svg')
              ),
            ),
          ),
        ),
        Text(
          nickname,
          style: TextStyle(
            fontSize: 12,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            color: GuamColorFamily.grayscaleGray3,
          ),
        ),
      ],
    );
  }
}
