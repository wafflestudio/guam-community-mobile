import 'package:flutter/material.dart';
import 'package:guam_community_client/models/boards/post.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PostPreviewBanner extends StatelessWidget {
  final Post post;

  PostPreviewBanner(this.post);

  colorOfInterest(String interest) {
    String textColor;

    switch (interest) {
      case '개발': textColor = '#6951FF'; break;
      case '데이터분석': textColor = '#75D973'; break;
      case '디자인': textColor = '#E874F2'; break;
      case '기획/마케팅': textColor = '#5483F1'; break;
      default: textColor = '#F3B962'; break;
    }
    return textColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 17,
          child: TextButton(
            onPressed: () {},
            child: Text(
              "#" + post.interest,
              style: TextStyle(
                fontSize: 12,
                color: HexColor(colorOfInterest(post.interest)),
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        Spacer(),
        Text(
          (DateTime.now().minute - post.createdAt.minute).toString() + "분 전",
          style: TextStyle(
            fontSize: 10,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            color: HexColor('#A0A0A0'),
          ),
        )
      ],
    );
  }
}
