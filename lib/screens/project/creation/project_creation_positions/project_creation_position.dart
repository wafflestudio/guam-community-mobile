import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_positions/project_creation_filter_chip.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_positions/project_creation_filter_value_chip.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_positions/project_creation_selected_positions.dart';
import 'package:guam_community_client/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../helpers/translatePosition.dart';

class ProjectCreationPosition extends StatefulWidget {
  final Map input;
  final Map<dynamic, List<dynamic>> filterOptions;
  final Function checkButtonEnable;

  ProjectCreationPosition({required this.input, required this.filterOptions, required this.checkButtonEnable});

  @override
  _ProjectCreationPositionState createState() => _ProjectCreationPositionState();
}

class _ProjectCreationPositionState extends State<ProjectCreationPosition> {
  String? selectedKey;
  List<TechStack>? filterValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            color: GuamColorFamily.grayscaleWhite,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    '포지션',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(children: [
                  ...widget.filterOptions.entries.map((e) => ProjectCreationFilterChip(
                    content: e.key,
                    display: translatePosition(e.key)!,
                    selected: selectedKey == e.key,
                    selectKey: selectKey,
                    filterValues: e.value,
                  ))
                ]),
                if (selectedKey != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          "인원",
                          style: TextStyle(fontSize: 15, color: GuamColorFamily.grayscaleGray1),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: headCounter()),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          "기술 스택",
                          style: TextStyle(fontSize: 15, color: GuamColorFamily.grayscaleGray1),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Wrap(
                          runSpacing: 5,
                          children: [
                            ...filterValues!.map((e) {
                              return ProjectCreationFilterValueChip(
                                techStack: e,
                                selected: widget.input[selectedKey]["techStack"] == e.name,
                                selectValue: selectValue,
                                checkButtonEnable: widget.checkButtonEnable,
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: ProjectCreationSelectedPositions(widget.input),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headCounter() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          child: RawMaterialButton(
            shape: CircleBorder(side: BorderSide(color: GuamColorFamily.grayscaleGray6, width: 1.5)),
            elevation: 1,
            fillColor: GuamColorFamily.grayscaleWhite,
            child: Icon(Icons.remove, color: GuamColorFamily.grayscaleGray2),
            onPressed: () {
              if (selectedKey != null) {
                minusHeadcount(selectedKey);
                widget.checkButtonEnable();
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            widget.input[selectedKey]["headCount"].toString(),
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        Container(
          width: 30,
          height: 30,
          child: RawMaterialButton(
            shape: CircleBorder(side: BorderSide(color: GuamColorFamily.grayscaleGray6, width: 1.5)),
            elevation: 1,
            fillColor: GuamColorFamily.grayscaleWhite,
            child: Icon(Icons.add, color: GuamColorFamily.grayscaleGray2),
            onPressed: () {
              if (selectedKey != null) {
                addHeadcount(selectedKey);
                widget.checkButtonEnable();
              }
            },
          ),
        ),
      ],
    );
  }

  void addHeadcount(tech) {
    widget.input[tech]["headCount"]++;
  }

  void minusHeadcount(tech) {
    if (widget.input[tech]["headCount"] > 0) widget.input[tech]["headCount"]--;
  }

  void selectKey(String key, List<TechStack> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(TechStack techStack) {
    setState(() {
      widget.input[selectedKey]["id"] = techStack.id;
      widget.input[selectedKey]["techStack"] = techStack.name;
    });
  }
}
