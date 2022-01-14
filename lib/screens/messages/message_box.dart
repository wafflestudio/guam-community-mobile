import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/messages/messages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'message_body.dart';

class MessageBox extends StatelessWidget {
  final bool newMessage = true;

  @override
  Widget build(BuildContext context) {
    final messagesProvider = context.read<Messages>();

    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
        icon: SvgPicture.asset(
          newMessage
            ? 'assets/icons/message_new.svg'
            : 'assets/icons/message_default.svg'
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (_) => MessageBody(
                  messagesProvider.messageBoxes,
                  messagesProvider.messages,
              )
            )
          );
        }
      ),
    );
  }
}
