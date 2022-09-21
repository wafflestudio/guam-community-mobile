import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:guam_community_client/screens/recruit/preview/project_preview.dart';
import 'package:guam_community_client/screens/recruit/preview/project_preview_square.dart';

import '../../commons/guam_progress_indicator.dart';
import '../../commons/sub_headings.dart';
import '../../styles/colors.dart';
import '../../styles/fonts.dart';

class ProjectList extends StatefulWidget {
  final List<Project> projects;
  final List<Project> impendingProjects;
  final Function refreshProject;
  final Function sortProjects;
  final bool isSorted;
  final bool hasNextPage;
  final bool isLoadMoreRunning;
  final ScrollController verticalScrollController;
  final ScrollController horizontalScrollController;

  ProjectList({required this.projects, required this.refreshProject,
    required this.impendingProjects, required this.sortProjects,
    required this.isSorted, required this.hasNextPage, required this.isLoadMoreRunning,
    required this.verticalScrollController, required this.horizontalScrollController});

  @override
  State<ProjectList> createState() => _PostListState();
}

class _PostListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: GuamColorFamily.purpleLight3), // backgrounds color
      child: ListView.builder(
          controller: widget.verticalScrollController,
          scrollDirection: Axis.vertical,
          itemCount: (widget.isLoadMoreRunning ||
              (widget.hasNextPage == false && widget.projects.length > 10)) ?
          widget.projects.length + 2 : widget.projects.length + 1,
          itemBuilder: (context, index){
            if(index == 0) return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 12, 0, 0),
                  child: SubHeadings("마감임박⏱"),
                ),
                SizedBox(
                  height: 112,
                  child: ListView.builder(
                      controller: widget.horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.impendingProjects.length,
                      itemBuilder: (context, index){
                        if(index == 0) return Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: ProjectPreviewSquare(idx: index, project: widget.impendingProjects[index], refreshProject: widget.refreshProject),
                        );
                        else if(index == widget.impendingProjects.length - 1)
                          return Padding(
                            padding: EdgeInsets.only(right: 1),
                            child: ProjectPreviewSquare(idx: index, project: widget.impendingProjects[index], refreshProject: widget.refreshProject),
                          );
                        return ProjectPreviewSquare(idx: index, project: widget.impendingProjects[index], refreshProject: widget.refreshProject);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 6, 0, 4),
                  child: SubHeadings("신규 프로젝트✨"),
                ),
              ],
            );
            else if(index == widget.projects.length + 1) {
              if(widget.hasNextPage == false && widget.projects.length > 10) return Container(
                color: GuamColorFamily.purpleLight2,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Center(child: Text(
                  '모든 프로젝트 불러왔습니다!',
                  style: TextStyle(
                    fontSize: 13,
                    color: GuamColorFamily.grayscaleGray2,
                    fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
                  ),
                )),
              );
              else return Padding(
                padding: EdgeInsets.only(top: 10, bottom: 40),
                child: guamProgressIndicator(size: 40),
              );
            } else {
              return ProjectPreview(idx: index, project: widget.projects[index - 1], refreshProject: widget.refreshProject);
            }
          }
      )
    );
  }
}