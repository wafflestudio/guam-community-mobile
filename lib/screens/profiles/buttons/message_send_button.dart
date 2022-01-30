import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/commons/bottom_modal/bottom_modal_with_text.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MessageSendButton extends StatelessWidget {
  final Profile otherProfile;

  MessageSendButton(this.otherProfile);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: InkWell(
        child: Container(
          width: 103,
          height: 31,
          decoration: BoxDecoration(
            color: GuamColorFamily.purpleLight3,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                constraints: BoxConstraints(),
                padding: EdgeInsets.only(right: 4),
                icon: SvgPicture.asset(
                  'assets/icons/message_default.svg',
                  color: GuamColorFamily.purpleCore,
                ),
                onPressed: null,
              ),
              Text(
                '쪽지 보내기',
                style: TextStyle(
                  color: GuamColorFamily.purpleCore,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        onTap: () => showMaterialModalBottomSheet(
          context: context,
          useRootNavigator: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          builder: (context) => Container(
            child: SingleChildScrollView(
              child: BottomModalWithText(
                funcName: '보내기',
                title: '${otherProfile.nickname} 님에게 쪽지 보내기',
                profile: otherProfile,
                func: null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
