import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreationFilterChip extends StatelessWidget {
  final String content;
  final String? display;
  final Function? selectKey;
  final bool selected;
  final List<dynamic> filterValues;

  ProjectCreationFilterChip({
    this.display,
    this.selectKey,
    required this.content,
    required this.selected,
    required this.filterValues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: ChoiceChip(
          label: Text(
            display ?? content,
            style: TextStyle(
              fontSize: 13,
              color: selected
                  ? GuamColorFamily.grayscaleWhite
                  : GuamColorFamily.grayscaleGray2,
            ),
          ),
          selected: selected,
          selectedColor: GuamColorFamily.purpleCore,
          backgroundColor: GuamColorFamily.grayscaleGray6,
          onSelected: (val) => selectKey!(content, filterValues),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        ),
      ),
    );
  }
}
