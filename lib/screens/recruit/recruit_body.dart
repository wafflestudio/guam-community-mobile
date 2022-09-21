import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:guam_community_client/screens/recruit/project_list.dart';
import 'package:provider/provider.dart';

import '../../commons/guam_progress_indicator.dart';
import '../../styles/colors.dart';

class RecruitBody extends StatefulWidget {
  @override
  State<RecruitBody> createState() => _RecruitBodyState();
}

class _RecruitBodyState extends State<RecruitBody> {
  List<Project>? _projects = [];
  List<Project>? _almostFullProjects = [];
  int? _beforeProjectId;
  int? _beforeAlmostFullProjectId;
  bool _isSorted = false;
  bool _hasNextPage = true;
  bool _hasNextPageHorizontal = true;
  bool _isFirstLoadRunning = false;
  bool _isFirstLoadRunningHorizontal = false;
  bool _isLoadMoreRunning = false;
  bool _isLoadMoreRunningHorizontal = false;
  bool _showBackToTopButton = false;

  ScrollController _verticalScrollController = ScrollController();
  ScrollController _horizontalScrollController = ScrollController();

  sortProjects(String filter) {
    setState(() {
      _isSorted = filter == '관심순' ? true : false;
      _firstLoad();
    });
    return _isSorted;
  }

  void _firstLoad() async {
    setState(() => _isFirstLoadRunning = true);
    try {
      if (!_isSorted) {
        // 시간순 정렬
        await context.read<Recruit>().fetchProjects();
        _projects = context.read<Recruit>().projects;
      } else {
        // 관심순(star) 정렬 (아직 api 없음)
        // await context.read<Recruit>().fetchStarredProjects(rankFrom: _rankFrom);
        // _projects = context.read<Recruit>().starredProjects;
      }
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunning = false);
  }

  void _firstLoadHorizontal() async {
    setState(() => _isFirstLoadRunningHorizontal = true);
    try {
      await context.read<Recruit>().fetchAlmostFullProjects();
      _almostFullProjects = context.read<Recruit>().almostFullProjects;
    } catch (err) {
      print('알 수 없는 오류가 발생했습니다.');
    }
    setState(() => _isFirstLoadRunningHorizontal = false);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _verticalScrollController.position.extentAfter < 300) {
      setState(() => _isLoadMoreRunning = true);
      _beforeProjectId = _projects!.last.id;
      try {
        final fetchedProjects = _isSorted
            // addStarredProjects 로 변경
            ? await context.read<Recruit>().addProjects(beforeProjectId: _beforeProjectId)
            : await context.read<Recruit>().addProjects(beforeProjectId: _beforeProjectId);
        if (fetchedProjects != null && fetchedProjects.length > 0) {
          // Exception : Concurrent modification during iteration => List.from()
          setState(() => _projects!.addAll(List.from(fetchedProjects)));
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() => _hasNextPage = false);
        }
      } catch (err) {
        print(err);
        print('알 수 없는 오류가 발생했습니다.');
      }
      setState(() => _isLoadMoreRunning = false);
    }
  }

  void _loadMoreHorizontal() async {
    if (_hasNextPageHorizontal == true &&
        _isFirstLoadRunningHorizontal == false &&
        _isLoadMoreRunningHorizontal == false &&
        _horizontalScrollController.position.extentAfter < 300) {
      setState(() => _isLoadMoreRunningHorizontal = true);
      _beforeAlmostFullProjectId = _almostFullProjects!.last.id;
      try {
        final fetchedProjects = await context.read<Recruit>().addAlmostFullProjects(beforeProjectId: _beforeAlmostFullProjectId);
        if (fetchedProjects != null && fetchedProjects.length > 0) {
          // Exception : Concurrent modification during iteration => List.from()
          setState(() => _almostFullProjects!.addAll(List.from(fetchedProjects)));
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() => _hasNextPageHorizontal = false);
        }
      } catch (err) {
        print(err);
        print('알 수 없는 오류가 발생했습니다.');
      }
      setState(() => _isLoadMoreRunningHorizontal = false);
    }
  }

  void refreshProject(int idx, Project refreshedProject) {
    setState(() {
      _projects!.elementAt(idx).starCount = refreshedProject.starCount;
      _projects!.elementAt(idx).starred = refreshedProject.starred;
    });
  }

  void _scrollToTop() => _verticalScrollController
      .animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    // setState() or markNeedsBuild called during build
    // https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
    Future.delayed(Duration.zero, () async {
      _firstLoad();
      _firstLoadHorizontal();
      _verticalScrollController = ScrollController()..addListener(_loadMore)
        ..addListener(() {
          setState(() {
            if (_verticalScrollController.offset >= 600) {
              _showBackToTopButton = true; // show the back-to-top button
            } else {
              _showBackToTopButton = false; // hide the back-to-top button
            }
          });
        });
      _horizontalScrollController = ScrollController()..addListener(_loadMoreHorizontal);
    });

  }

  @override
  void dispose() {
    _verticalScrollController.removeListener(_loadMore);
    _horizontalScrollController.removeListener(_loadMoreHorizontal);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstLoadRunning
        ? Center(child: guamProgressIndicator())
        : Stack(
      children: [
        RefreshIndicator(
          color: Color(0xF9F8FFF), // GuamColorFamily.purpleLight1
          onRefresh: () async => _firstLoad(),
          child: Container(
            height: double.infinity,
            child: ProjectList(projects: _projects!,
              refreshProject: refreshProject,
              impendingProjects: _almostFullProjects!,
              sortProjects: sortProjects,
              isSorted: _isSorted,
              hasNextPage: _hasNextPage,
              isLoadMoreRunning: _isLoadMoreRunning,
              verticalScrollController: _verticalScrollController,
              horizontalScrollController: _horizontalScrollController,),
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