import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/common_img_nickname.dart';
import 'package:guam_community_client/styles/colors.dart';

class MentionField extends StatefulWidget {
  final List<Map<String, dynamic>> mentionList;
  final Function(int id, String nickname) setMentionTarget;

  MentionField(this.mentionList, this.setMentionTarget);

  @override
  _MentionFieldState createState() => _MentionFieldState();
}

class _MentionFieldState extends State<MentionField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 160,
      color: GuamColorFamily.purpleLight2.withOpacity(0.9),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.mentionList.map(
              (target) => InkWell(
                onTap: () => widget.setMentionTarget(target['id'], target['nickname']),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: CommonImgNickname(
                    imgUrl: target['profileImg']['urlPath'],
                    nickname: target['nickname'],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
