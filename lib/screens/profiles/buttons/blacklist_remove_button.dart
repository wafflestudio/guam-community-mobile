import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../commons/common_text_button.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:guam_community_client/styles/fonts.dart';

import '../../../providers/user_auth/authenticate.dart';

class BlackListRemoveButton extends StatefulWidget {
  final int blockedUserId;
  final Function firstLoad;

  BlackListRemoveButton(this.blockedUserId, this.firstLoad);

  @override
  State<BlackListRemoveButton> createState() => _BlackListRemoveButtonState();
}

class _BlackListRemoveButtonState extends State<BlackListRemoveButton> {
  @override
  Widget build(BuildContext context) {
    bool sending = false;

    void toggleSending() {
      setState(() => sending = !sending);
    }

    Future deleteInterest() async {
      print(widget.blockedUserId);

      toggleSending();
      try {
        await context.read<Authenticate>().deleteBlockedUser(
          widget.blockedUserId
        ).then((successful) {
          toggleSending();
          if (successful) {
            widget.firstLoad();
          } else {
            print("Error!");
          }
        });
      } catch (e) {
        print(e);
      }
    }

    return CommonTextButton(
      text: '해제',
      fontSize: 15,
      fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
      textColor: GuamColorFamily.grayscaleGray3,
      onPressed: () => deleteInterest(),
    );
  }
}
