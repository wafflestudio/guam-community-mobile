import 'package:flutter/material.dart';
import 'package:guam_community_client/commons/buttons/previous_button.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_due.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_modal.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_positions/project_creation_position.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../commons/buttons/next_button.dart';
import '../../../models/projects/tech_stack.dart';
import '../../../styles/colors.dart';

class ProjectCreationPageTwo extends StatefulWidget {
  final Map input;
  final List<bool> dueSelected;
  final Map<String, List<TechStack>> filterOptions;
  final Function goToPreviousPage;

  ProjectCreationPageTwo({
    required this.input,
    required this.dueSelected,
    required this.filterOptions,
    required this.goToPreviousPage,
  });

  @override
  _ProjectCreationPageTwoState createState() => _ProjectCreationPageTwoState();
}

class _ProjectCreationPageTwoState extends State<ProjectCreationPageTwo> {
  bool nextBtnEnabled = false;

  @override
  void initState() {
    nextBtnEnabled = widget.input['due'] != null &&
        (widget.input['SERVER']['id'] != 0 &&
            widget.input['SERVER']['headCount'] != 0) ||
        (widget.input['WEB']['id'] != 0 &&
            widget.input['WEB']['headCount'] != 0) ||
        (widget.input['MOBILE']['id'] != 0 &&
            widget.input['MOBILE']['headCount'] != 0) ||
        (widget.input['DESIGNER']['id'] != 0 &&
            widget.input['DESIGNER']['headCount'] != 0);
    super.initState();
  }

  /// due && position이 채워지면 버튼 활성화
  void checkButtonEnable() {
    setState(() {
      nextBtnEnabled = widget.input['due'] != null &&
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProjectCreationDue(
          input: widget.input,
          dueSelected: widget.dueSelected,
          checkButtonEnable: checkButtonEnable,
        ),
        ProjectCreationPosition(
          input: widget.input,
          filterOptions: widget.filterOptions,
          checkButtonEnable: checkButtonEnable,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PreviousButton(page: 2, onTap: widget.goToPreviousPage),
              NextButton(
                page: 2,
                active: nextBtnEnabled,
                onTap: () => showMaterialModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  backgroundColor: GuamColorFamily.grayscaleWhite,
                  builder: (context) => ProjectCreationModal(widget.input),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
