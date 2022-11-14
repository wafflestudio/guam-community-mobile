import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreationDue extends StatefulWidget {
  final Map input;
  final List<bool> dueSelected;
  final Function checkButtonEnable;

  ProjectCreationDue({
    required this.input,
    required this.dueSelected,
    required this.checkButtonEnable,
  });

  @override
  State createState() => _ProjectCreationDueState();
}

class _ProjectCreationDueState extends State<ProjectCreationDue> {
  String? selectedKey;
  final List<String> _periods = ['미정', '1개월 미만', '3개월 미만', '6개월 미만', '6개월 이상'];

  void saveDue(idx) => setState(() => widget.input["due"] = idx);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GuamColorFamily.grayscaleWhite,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, bottom: 10),
            child: Text(
              '진행 기간',
              style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray1),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._periods.map((e) => Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: ChoiceChip(
                    selected: selectedKey == e,
                    selectedColor: GuamColorFamily.purpleCore,
                    backgroundColor: GuamColorFamily.grayscaleGray6,
                    onSelected: (val) {
                      setState(() {
                        widget.checkButtonEnable();
                        saveDue(_periods.indexOf(e));
                        selectedKey = selectedKey == e ? null : e;
                      });
                    },
                    label: Text(
                      e,
                      style: TextStyle(
                        fontSize: 13,
                        color: selectedKey == e
                            ? GuamColorFamily.grayscaleWhite
                            : GuamColorFamily.grayscaleGray2,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
