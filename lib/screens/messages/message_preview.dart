import 'package:flutter/material.dart';
import 'package:guam_community_client/helpers/svg_provider.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MessageDetail(
                  messages,
                  messageBox.otherProfile.nickname,
                )
              ));
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
                              ? NetworkImage(messageBox.otherProfile.profileImg.urlPath)
                              : SvgProvider('assets/icons/profile_image.svg')
                        ),
                      ),
                    ),
                    if (!messageBox.isRead)
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          backgroundColor: GuamColorFamily.FuchsiaCore,
                          radius: 6,
                        )
                      ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
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
                        messageBox.lastContent,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                          color: messageBox.isRead
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
                    (DateTime.now().minute - messageBox.createdAt.minute).toString() + "분 전",
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
