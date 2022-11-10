import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/project/techStacks.dart';
import 'package:guam_community_client/screens/project/buttons/search_button.dart';
import 'package:guam_community_client/screens/recruit/recruit_body.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import '../../providers/recruit/recruit.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../styles/colors.dart';
import 'buttons/create_project_button.dart';

class ProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.read<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Recruit(authProvider)),
        ChangeNotifierProvider(create: (_) => TechStacks()),
      ],
      child: ProjectAppScaffold(),
    );
  }
}

class ProjectAppScaffold extends StatefulWidget {
  @override
  State<ProjectAppScaffold> createState() => _ProjectAppScaffoldState();
}

class _ProjectAppScaffoldState extends State<ProjectAppScaffold> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: GuamColorFamily.purpleLight3,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: CustomAppBar(
            title: '프로젝트',
            trailing: SearchButton(),
            bottom: TabBar(
              isScrollable: false,
              physics: BouncingScrollPhysics(),
              labelColor: GuamColorFamily.grayscaleGray1,
              unselectedLabelColor: GuamColorFamily.grayscaleGray4,
              indicatorColor: GuamColorFamily.grayscaleGray1,
              indicatorWeight: 2,
              tabs: [
                Tab(
                    child: Text('리크루팅'),
                ),
                Tab(
                    child: Text('작업실'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            RecruitBody(),
            Container(),
          ],
        ),
        floatingActionButton: CreateProjectButton(),
      ),
    );
  }
}