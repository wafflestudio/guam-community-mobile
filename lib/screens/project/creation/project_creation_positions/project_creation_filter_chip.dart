import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreationFilterChip extends StatelessWidget {
  final String content;
  final String display;
  final Function selectKey;
  final bool selected;
  final List<TechStack> filterValues;

  ProjectCreationFilterChip({
    required this.content,
    required this.display,
    required this.selectKey,
    required this.selected,
    required this.filterValues,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: ChoiceChip(
          label: Text(
            display,
            style: TextStyle(
              fontSize: 14,
              color: selected
                  ? GuamColorFamily.grayscaleGray1
                  : GuamColorFamily.grayscaleWhite,
            ),
          ),
          selected: selected,
          backgroundColor: GuamColorFamily.purpleDark1,
          selectedColor: GuamColorFamily.blueCore,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          onSelected: (val) => selectKey(content, filterValues),
        ),
      ),
    );
  }
}
