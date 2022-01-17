import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonImgNickname extends StatelessWidget {
  final String imgUrl;
  final String nickname;
  final HexColor nicknameColor;
  final bool profileClickable;

  CommonImgNickname({this.imgUrl, this.nickname, this.nicknameColor, this.profileClickable=true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: profileClickable ? () {} : null,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8),
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
              color: nicknameColor,
            ),
          ),
        ],
      ),
    );
  }
}
