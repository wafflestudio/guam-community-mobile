import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:intl/intl.dart';

class MessageDetailBody extends StatelessWidget {
  final Message message;

  MessageDetailBody(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: message.isMe
          ? GuamColorFamily.grayscaleGray7
          : GuamColorFamily.purpleLight3,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: message.profile.profileImg != null
                        ? NetworkImage(message.profile.profileImg.urlPath)
                        : SvgProvider('assets/icons/profile_image.svg')
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  message.isMe
                      ? message.profile.nickname + ' (나)'
                      : message.profile.nickname,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    color: message.isMe
                        ? GuamColorFamily.purpleCore
                        : GuamColorFamily.grayscaleGray2,
                  ),
                ),
              ),
              Spacer(),
              Text(
                DateFormat('yyyy.MM.dd  HH:mm').format(message.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  color: GuamColorFamily.grayscaleGray4,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              message.content,
              style: TextStyle(
                height: 1.6,
                fontSize: 13,
                color: GuamColorFamily.grayscaleGray2,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
              ),
            ),
          ),
          if (message.picture != null)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(message.picture.urlPath),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
