import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/models/messages/message.dart';
import 'package:guam_community_client/models/messages/message_box.dart' as MessageBox;
import 'package:provider/provider.dart';
import 'package:guam_community_client/commons/back.dart';
import 'package:guam_community_client/commons/custom_app_bar.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:guam_community_client/styles/colors.dart';

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
            onPressed: () {},
          )
        ),
      ),
      body: Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(top: 18),
        child: Column(
            children: [
              ...messageBoxes.map((messageBox) => MessagePreview(messageBox, messages)
              )
            ]
        ),
      ),
    );
  }
}
