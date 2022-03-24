import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:guam_community_client/commons/icon_text.dart';
import 'package:guam_community_client/models/boards/comment.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentBody extends StatelessWidget {
  final Comment comment;

  CommentBody(this.comment);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 32, right: 12),
          child: Linkify(
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              } else {
                throw 'Could not launch $link';
              }
            },
            text: comment.content,
            style: TextStyle(
              height: 1.6,
              fontSize: 13,
              color: GuamColorFamily.grayscaleGray2,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
            linkStyle: TextStyle(
              height: 1.6,
              fontSize: 14,
              color: GuamColorFamily.blueCore,
              fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32, top: 4, bottom: 8),
          child: Row(
            children: [
              IconText(
                iconSize: 18,
                fontSize: 10,
                text: comment.likeCount.toString(),
                iconPath: comment.isLiked ?? false  /// 서버 수정 후 ?? false 삭제
                    ? 'assets/icons/like_filled.svg'
                    : 'assets/icons/like_outlined.svg',
                onPressed: (){},
                iconColor: comment.isLiked ?? false  /// 서버 수정 후 ?? false 삭제
                    ? GuamColorFamily.redCore
                    : GuamColorFamily.grayscaleGray5,
                textColor: GuamColorFamily.grayscaleGray5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  Jiffy(comment.createdAt).fromNow(),
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: GuamColorFamily.grayscaleGray4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
