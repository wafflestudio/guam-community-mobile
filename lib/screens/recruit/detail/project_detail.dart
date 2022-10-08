import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/screens/recruit/detail/project_detail_apply.dart';
import 'package:guam_community_client/screens/recruit/detail/project_detail_description.dart';
import 'package:guam_community_client/screens/recruit/detail/project_detail_info.dart';

import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';

class ProjectDetail extends StatelessWidget {
  final Project? project;

  ProjectDetail(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "프로젝트",
        leading: Back(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            ProjectDetailDescription(project!),
            ProjectDetailInfo(project!),
            ProjectDetailApply(project!),
          ]),
        ),
      ),
    );
  }
}
