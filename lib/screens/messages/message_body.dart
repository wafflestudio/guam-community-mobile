import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart' as MessageBox;
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/screens/messages/message_box_edit.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import 'message_preview.dart';

class MessageBody extends StatelessWidget {
  final List<MessageBox.MessageBox> messageBoxes;
  final List<Message> messages;

  MessageBody(this.messageBoxes, this.messages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '쪽지함',
        leading: Back(),
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset('assets/icons/delete_outlined.svg'),
            onPressed: () => Navigator.of(context, rootNavigator: true).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => MessageBoxEdit(messageBoxes, messages),
                transitionDuration: Duration(seconds: 0),
              )
            ),
          )
        ),
      ),
      body: Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            if (messageBoxes.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                  child: Text(
                    '쪽지함이 비어있습니다.',
                    style: TextStyle(
                      fontSize: 16,
                      color: GuamColorFamily.grayscaleGray4,
                      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                    ),
                  ),
                ),
              ),
            if (messageBoxes.isNotEmpty)
              ...messageBoxes.map((messageBox) => MessagePreview(messageBox, messages)
            )
          ]
        ),
      ),
    );
  }
}
