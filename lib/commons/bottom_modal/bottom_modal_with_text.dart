import 'package:flutter/material.dart';
import 'package:guam_community_client/models/profiles/profile.dart';
import 'package:guam_community_client/screens/messages/message_bottom_modal.dart';
import 'package:guam_community_client/styles/colors.dart';

class BottomModalWithText extends StatelessWidget {
  final String funcName;
  final String title;
  final Profile profile;
  final Function func;

  BottomModalWithText({this.funcName, this.title, this.profile, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
      decoration: BoxDecoration(
        color: GuamColorFamily.grayscaleWhite,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
              ),
              TextButton(
                child: Text(
                  '취소',
                  style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(30, 26),
                  alignment: Alignment.centerRight,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 24)),
          MessageBottomModal(),
          Padding(padding: EdgeInsets.only(bottom: 24)),
          Center(
            child: TextButton(
              onPressed: () => func,
              child: Text(
                funcName,
                style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
