import 'package:flutter/material.dart';
import 'package:guam_community_client/providers/recruit/recruit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../commons/common_img_nickname.dart';
import '../../../commons/icon_text.dart';
import '../../../models/projects/project.dart';
import '../../../styles/colors.dart';

class ProjectPreviewInfo extends StatefulWidget {
  final int index;
  final Project project;
  final Function? refreshProject;
  final double iconSize;
  final bool profileClickable;
  final HexColor? iconColor;

  ProjectPreviewInfo({
    required this.index,
    required this.project,
    this.refreshProject,
    this.iconSize = 20,
    this.profileClickable = true,
    this.iconColor,
  });

  @override
  State<ProjectPreviewInfo> createState() => _ProjectPreviewInfoState();
}

class _ProjectPreviewInfoState extends State<ProjectPreviewInfo> {
  bool? starred;
  int? starCount;

  @override
  void initState() {
    starred = widget.project.starred!;
    starCount = widget.project.starCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recruitProvider = context.watch<Recruit>();

    Future starOrUnStarPost() async {
      try {
        if (!starred!) {
          return await recruitProvider.starProject(
            projectId: widget.project.id,
          ).then((successful) async {
            if (successful) {
              Project? _temp = await recruitProvider.getProject(widget.project.id);
              starred = _temp!.starred;
              starCount = _temp.starCount;
              widget.refreshProject!(widget.index, _temp);
            } else {
              return recruitProvider.fetchProjects();
            }
          });
        } else {
          return await recruitProvider.unStarPost(
            projectId: widget.project.id,
          ).then((successful) async {
            if (successful) {
              Project? _temp = await recruitProvider.getProject(widget.project.id);
              starred = _temp!.starred;
              starCount = _temp.starCount;
              widget.refreshProject!(widget.index, _temp);
            } else {
              return recruitProvider.fetchProjects();
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        children: [
            CommonImgNickname(
              imgUrl: widget.project.leader!.profileImg,
              nickname: widget.project.leader!.nickname,
              profileClickable: widget.profileClickable,
              nicknameColor: GuamColorFamily.grayscaleGray2,
            ),
          Spacer(),
          Row(
            children: [
              IconText(
                iconSize: widget.iconSize,
                text: starCount.toString(),
                iconPath: starred!
                    ? 'assets/icons/star_filled.svg'
                    : 'assets/icons/star_outlined.svg',
                onPressed: starOrUnStarPost,
                iconColor: starred!
                    ? GuamColorFamily.orangeCore
                    : widget.iconColor,
                textColor: widget.iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
