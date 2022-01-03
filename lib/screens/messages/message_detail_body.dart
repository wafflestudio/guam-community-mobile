import 'package:flutter/material.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:intl/intl.dart';

class MessageDetailBody extends StatelessWidget {
  final Message message;

  MessageDetailBody(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                message.profile.nickname,
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
                DateFormat('yyyy.MM.dd  HH:mm').format(message.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray5,
                ),
              ),
            ),
          ],
        ),
        Text(message.content),
        if (message.picture != null)
          Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(message.picture.urlPath)
                ),
              ),
            ),
          ),
      ],
    );
  }
}
