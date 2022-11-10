import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreationFilterValueChip extends StatelessWidget {
  final TechStack techStack;
  final bool selected;
  final Function selectValue;
  final Function checkButtonEnable;

  ProjectCreationFilterValueChip({
    required this.techStack,
    required this.selected,
    required this.selectValue,
    required this.checkButtonEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: ChoiceChip(
        selected: selected,
        backgroundColor: GuamColorFamily.purpleLight3,
        selectedColor: GuamColorFamily.grayscaleWhite,
        onSelected: (val) {
          selectValue(techStack);
          checkButtonEnable();
        },
        label: Text(
          techStack.name!,
          style: TextStyle(
            fontSize: 12,
            color: selected ? GuamColorFamily.blueCore : GuamColorFamily.purpleLight1,
          ),
        ),
      ),
    );
  }
}
