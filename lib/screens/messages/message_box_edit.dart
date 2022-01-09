import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart' as MessageBox;
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import 'message_preview.dart';

class MessageBoxEdit extends StatelessWidget {
  final List<MessageBox.MessageBox> messageBoxes;
  final List<Message> messages;

  MessageBoxEdit(this.messageBoxes, this.messages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GuamColorFamily.grayscaleWhite,
      appBar: CustomAppBar(
        title: '쪽지함',
        leading: null,
        trailing: Padding(
          padding: EdgeInsets.only(right: 11),
          child: TextButton(
            child: Text(
              '완료',
              style: TextStyle(
                fontSize: 16,
                color: GuamColorFamily.purpleCore,
                fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium,
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ),
      ),
      body: Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(top: 18),
        child: Column(
          children: [
            ...messageBoxes.map((messageBox) => MessagePreview(
              messageBox,
              messages,
              editable: true,
            ))
          ]
        ),
      ),
    );
  }
}
