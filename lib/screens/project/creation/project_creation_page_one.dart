import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/buttons/next_button.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_description.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_thumbnail.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_title.dart';

class ProjectCreationPageOne extends StatefulWidget {
  final Map input;
  final Function goToNextPage;

  ProjectCreationPageOne({
    required this.input,
    required this.goToNextPage,
  });

  @override
  State<StatefulWidget> createState() => ProjectCreationPageOneState();
}

class ProjectCreationPageOneState extends State<ProjectCreationPageOne> {
  bool nextBtnEnabled = false;

  @override
  void initState() {
    nextBtnEnabled =
        widget.input['title'] != '' && widget.input['description'] != '';
    super.initState();
  }

  void checkButtonEnable() => setState(() => nextBtnEnabled =
      widget.input['title'] != '' && widget.input['description'] != '');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProjectCreateTitle(input: widget.input, checkButtonEnable: checkButtonEnable),
          ProjectCreateDescription(input: widget.input, checkButtonEnable: checkButtonEnable),
          ProjectCreationThumbnail(widget.input),
          Align(
            alignment: Alignment.bottomCenter,
            child: NextButton(
              page: 1,
              active: nextBtnEnabled,
              onTap: widget.goToNextPage,
            ),
          )
        ],
      ),
    );
  }
}
