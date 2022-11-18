import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:guam_community_client/screens/recruit/preview/project_preview.dart';
import 'package:provider/provider.dart';

import '../../../commons/guam_progress_indicator.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class ProjectSearchBody extends StatefulWidget {
  final Map filter;
  ProjectSearchBody({required this.filter});
  @override
  State<ProjectSearchBody> createState() => _ProjectSearchBodyState();
}

class _ProjectSearchBodyState extends State<ProjectSearchBody> {
  List<Project> _searchedProjects = [];
  int? _beforeProjectId;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _showBackToTopButton = false;
  ScrollController _scrollController = ScrollController();

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      _searchedProjects = context.read<Recruit>().searchedProjects;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 600) {
      setState(() => _isLoadMoreRunning = true);
      _beforeProjectId = _searchedProjects.last.id;
      try {
        final fetchedProjects = await context.read<Recruit>().addSearchedProjects(
          skill: widget.filter['skill'],
          position: widget.filter['position'],
          due: widget.filter['due'],
          beforeProjectId: _beforeProjectId,
        );
        if (fetchedProjects != null && fetchedProjects.length > 0) {
          setState(() => _searchedProjects.addAll(List.from(fetchedProjects)));
        } else {
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print('알 수 없는 오류가 발생했습니다.$err');
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  void refreshProject(int idx, Project project) {
    setState(() {
      _searchedProjects.removeAt(idx);
    });
  }

  void _scrollToTop() => _scrollController
      .animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);

  @override
  void initState() {
    _firstLoad();

    _scrollController = ScrollController()..addListener(_loadMore)
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 300) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recruitProvider = context.watch<Recruit>();

    return _isFirstLoadRunning
        ? Center(child: guamProgressIndicator())
        : Stack(
      children: [
        RefreshIndicator(
          color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
          onRefresh: () async => _firstLoad(),
          child: Container(
            height: double.infinity,
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (_isLoadMoreRunning || (!_hasNextPage && _searchedProjects.length > 10))
                    ? _searchedProjects.length + 1 : _searchedProjects.length,
                itemBuilder: (context, index){
                  if(index == _searchedProjects.length){
                    if(_isLoadMoreRunning) return Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: guamProgressIndicator(size: 40),
                    );
                    else return Container(
                      color: GuamColorFamily.purpleLight2,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(child: Text(
                        '모든 프로젝트를 불러왔습니다!',
                        style: TextStyle(
                          fontSize: 13,
                          color: GuamColorFamily.grayscaleGray2,
                          fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                        ),
                      )),
                    );
                  }
                  else if(index == _searchedProjects.length-1) return Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: ProjectPreview(idx : index, project: _searchedProjects[index], refreshProject: refreshProject),
                  );
                  else return ProjectPreview(idx: index, project: _searchedProjects[index], refreshProject: refreshProject);
                }),
          ),
        ),
        if (_showBackToTopButton)
          Positioned(
            top: 10,
            right: 10,
            child: FloatingActionButton(
              mini: true,
              onPressed: _scrollToTop,
              backgroundColor: GuamColorFamily.purpleLight1,
              child: Icon(Icons.arrow_upward, size: 20, color: GuamColorFamily.grayscaleWhite),
            ),
          ),
      ],
    );
  }
}