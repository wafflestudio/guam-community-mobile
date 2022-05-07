import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';
import 'package:jiffy/jiffy.dart';

import 'message_detail.dart';

class MessagePreview extends StatelessWidget {
  final MessageBox messageBox;
  final List<Message> messages;
  final bool editable;

  MessagePreview(this.messageBox, this.messages, {this.editable=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.only(left: 12, top: 6, bottom: 6),
          child: InkWell(
            onTap: () {
              // 쪽지함 수정 페이지에서는 쪽지 클릭 후 이동 불가능
              if (!editable)
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MessageDetail(
                    messages,
                    messageBox.otherProfile,
                  ))
                );
            },
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: messageBox.otherProfile.profileImg != null
                              ? NetworkImage(messageBox.otherProfile.profileImg)
                              : SvgProvider('assets/icons/profile_image.svg')
                        ),
                      ),
                    ),
                    if (!messageBox.latestLetter.isRead)
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          backgroundColor: GuamColorFamily.fuchsiaCore,
                          radius: 6,
                        )
                      ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.64,
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        messageBox.otherProfile.nickname,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
                          color: GuamColorFamily.grayscaleGray2,
                        ),
                      ),
                      Text(
                        messageBox.latestLetter.text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                          color: messageBox.latestLetter.isRead
                              ? GuamColorFamily.grayscaleGray4
                              : GuamColorFamily.grayscaleGray2,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                if (editable)
                  TextButton(
                    onPressed: (){},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(23, 20),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
                        color: GuamColorFamily.redCore,
                      ),
                    ),
                  ),
                if (!editable)
                Padding(
                  padding: EdgeInsets.only(right: 10, top: 14, bottom: 15),
                  child: Text(
                    Jiffy(messageBox.latestLetter.createdAt).fromNow(),
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.6,
                      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                      color: GuamColorFamily.grayscaleGray4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
