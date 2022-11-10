import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/buttons/next_button.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_description.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_thumbnail.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_title.dart';

class ProjectCreationPageOne extends StatefulWidget {
  final Map input;
  final bool isNewProject;
  final List<bool> dueSelected;
  final Function goToNextPage;

  ProjectCreationPageOne({
    required this.input,
    required this.dueSelected,
    required this.goToNextPage,
    this.isNewProject=false,
  });

  @override
  State<StatefulWidget> createState() => ProjectCreationPageOneState();
}

class ProjectCreationPageOneState extends State<ProjectCreationPageOne> {
  bool nextBtnEnabled = false;

  @override
  void initState() {
    nextBtnEnabled = widget.input['title'] != '' &&
        widget.input['description'] != '';
        // && widget.input['due'] != null;
    super.initState();
  }

  void checkButtonEnable() => setState(() {
        nextBtnEnabled = widget.input['title'] != '' &&
            widget.input['description'] != '';
            // && widget.input['due'] != null;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectCreateTitle(input: widget.input, checkButtonEnable: checkButtonEnable),
          ProjectCreateDescription(input: widget.input, checkButtonEnable: checkButtonEnable),
          ProjectCreationThumbnail(widget.input),
          NextButton(
            page: 1,
            label: '다음',
            active: nextBtnEnabled,
            onTap: widget.goToNextPage,
          )
        ],
      ),
    );
  }
}
