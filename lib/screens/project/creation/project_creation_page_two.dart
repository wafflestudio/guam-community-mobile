import 'package:flutter/material.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_positions/project_creation_position.dart';

import '../../../commons/buttons/next_button.dart';
import '../../../models/projects/tech_stack.dart';

class ProjectCreationPageTwo extends StatefulWidget {
  final Map input;
  final Map<String, List<TechStack>> filterOptions;
  final Function goToNextPage;
  final Function goToPreviousPage;

  ProjectCreationPageTwo({
    required this.input,
    required this.filterOptions,
    required this.goToNextPage,
    required this.goToPreviousPage,
  });

  @override
  _ProjectCreationPageTwoState createState() => _ProjectCreationPageTwoState();
}

class _ProjectCreationPageTwoState extends State<ProjectCreationPageTwo> {
  bool nextBtnEnabled = false;

  void checkButtonEnable() {
    setState(() {
      nextBtnEnabled =
          (widget.input['SERVER']['id'] != 0 &&
              widget.input['SERVER']['headCount'] != 0) ||
          (widget.input['WEB']['id'] != 0 &&
              widget.input['WEB']['headCount'] != 0) ||
          (widget.input['MOBILE']['id'] != 0 &&
              widget.input['MOBILE']['headCount'] != 0) ||
          (widget.input['DESIGNER']['id'] != 0 &&
              widget.input['DESIGNER']['headCount'] != 0);
    });
  }

  @override
  void initState() {
    super.initState();
    nextBtnEnabled = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProjectCreationPosition(
          input: widget.input,
          filterOptions: widget.filterOptions,
          checkButtonEnable: checkButtonEnable,
        ),
        NextButton(
          page: 2,
          label: '다음',
          active: nextBtnEnabled,
          onTap: widget.goToNextPage,
        ),
      ],
    );
  }
}
