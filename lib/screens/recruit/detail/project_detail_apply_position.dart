import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectDetailApplyPosition extends StatelessWidget {
  final String? myPosition;
  final Function setMyPosition;
  final Map<String, dynamic> pos = {
    'SERVER': {'label': '서버'},
    'WEB': {'label': '웹'},
    'MOBILE': {'label': '모바일'},
    'DESIGNER': {'label': '디자이너'},
  };

  ProjectDetailApplyPosition({required this.myPosition, required this.setMyPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: GuamColorFamily.grayscaleGray7,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: GuamColorFamily.grayscaleWhite, width: 0.5),
      ),
      child: ToggleButtons(
        borderWidth: 0.1,
        borderRadius: BorderRadius.circular(10),
        fillColor: GuamColorFamily.purpleLight1,
        borderColor: GuamColorFamily.grayscaleGray2,
        isSelected: [...pos.keys.map((e) => e == myPosition)],
        constraints: BoxConstraints(
          minHeight: 40,
          minWidth: MediaQuery.of(context).size.width * 0.85 / pos.length,
        ),
        onPressed: (idx) {
          final String pressedKey = pos.keys.toList()[idx];
          setMyPosition(myPosition == pressedKey ? null : pressedKey);
        },
        children: [...pos.entries.map((e) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            e.value['label'],
            style: TextStyle(
              fontSize: 13,
              color: e.key == myPosition
                  ? GuamColorFamily.grayscaleWhite
                  : GuamColorFamily.grayscaleGray3,
            ),
          ),
        ))],
      ),
    );
  }
}
