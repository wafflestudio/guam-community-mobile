import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'message_body.dart';

class MessageBox extends StatelessWidget {
  bool newMessage = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        newMessage
          ? 'assets/icons/message_new.svg'
          : 'assets/icons/message_default.svg'
      ),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => MessageBody()
              )
          );
        }
    );
  }
}
