import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/tech_stack.dart';
import 'package:guam_community_client/providers/project/techStacks.dart';
import 'package:guam_community_client/screens/project/creation/project_creation_page_one.dart';
import 'package:guam_community_client/styles/colors.dart';

import '../../../commons/custom_app_bar.dart';
import 'project_creation_page_two.dart';

class ProjectCreate extends StatefulWidget {
  final TechStacks techStacksProvider;

  ProjectCreate({required this.techStacksProvider});

  @override
  _ProjectCreateState createState() => _ProjectCreateState();
}

class _ProjectCreateState extends State<ProjectCreate> {
  Map input = {
    'title': '',
    'description': '',
    'due': '',
    'SERVER': {'id': 0, 'techStack': '', 'headCount': 0},
    'WEB': {'id': 0, 'techStack': '', 'headCount': 0},
    'MOBILE': {'id': 0, 'techStack': '', 'headCount': 0},
    'DESIGNER': {'id': 0, 'techStack': '', 'headCount': 0},
    'thumbnail': null,
    'isThumbnailChanged': false,
  };

  Map<String, List<TechStack>> _filterOptions = {
    'SERVER': [],
    'WEB': [],
    'MOBILE': [],
    'DESIGNER': [],
  };

  final dueSelected = <bool>[false, false, false, false];
  final positionSelected = <bool>[false, false, false, false];

  int _currentPage = 1;

  @override
  void initState() {
    widget.techStacksProvider.techStacks
        .forEach((e) => _filterOptions[e.position]?.add(e));
    super.initState();
  }

  void goToNextPage() => setState(() => _currentPage++);

  void goToPreviousPage() => setState(() => _currentPage--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '프로젝트 만들기',
        trailing: TextButton(
          onPressed: () => Navigator.maybePop(context),
          style: TextButton.styleFrom(
            minimumSize: Size(30, 26),
            alignment: Alignment.center,
          ),
          child: Text(
            '취소',
            style: TextStyle(
              color: GuamColorFamily.grayscaleWhite,
              fontSize: 16,
            ),
          ),
        ),
        titleColor: GuamColorFamily.grayscaleWhite,
        backgroundColor: GuamColorFamily.purpleDark1,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5),
        color: GuamColorFamily.purpleLight3,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPage == 1)
                ProjectCreationPageOne(
                  input: input,
                  dueSelected: dueSelected,
                  goToNextPage: goToNextPage,
                ),
              if (_currentPage == 2)
                ProjectCreationPageTwo(
                  input: input,
                  filterOptions: _filterOptions,
                  goToNextPage: goToNextPage,
                  goToPreviousPage: goToPreviousPage,
                ),
              // if (_currentPage == 3)
              //   ProjectCreatePageThree(
              //     input: input,
              //     positionSelected: positionSelected,
              //     goToPreviousPage: goToPreviousPage,
              //     isNewProject: true,
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
