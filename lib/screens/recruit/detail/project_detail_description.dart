import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:provider/provider.dart';

import '../../../commons/common_img_nickname.dart';
import '../../../commons/icon_text.dart';
import '../../../providers/recruit/recruit.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class ProjectDetailDescription extends StatefulWidget {
  final Project project;

  ProjectDetailDescription(this.project);

  @override
  State<ProjectDetailDescription> createState() => _ProjectDetailDescriptionState();
}

class _ProjectDetailDescriptionState extends State<ProjectDetailDescription> {
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
        if (!widget.project.starred!) {
          return await recruitProvider.starProject(
            projectId: widget.project.id,
          ).then((successful) async {
            if (successful) {
              Project? _temp = await recruitProvider.getProject(widget.project.id);
              widget.project.starred = _temp!.starred;
              widget.project.starCount = _temp.starCount;
              // widget.refreshProject!(widget.index, _temp);
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
              // widget.refreshProject!(widget.index, _temp);
            } else {
              return recruitProvider.fetchProjects();
            }
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          widget.project.title ?? "빈 제목",
          style: TextStyle(fontSize: 20, fontFamily: GuamFontFamily.SpoqaHanSansNeoMedium),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            CommonImgNickname(
              userId: widget.project.leader!.id,
              nickname: widget.project.leader!.nickname,
              imgUrl: widget.project.leader!.profileImg ?? null,
              nicknameColor: GuamColorFamily.grayscaleGray3,
            ),
            Spacer(),
            IconText(
              iconSize: 20,
              text: widget.project.starCount.toString(),
              iconPath: widget.project.starred!
                  ? 'assets/icons/star_filled.svg'
                  : 'assets/icons/star_outlined.svg',
              onPressed: starOrUnStarPost,
              iconColor: widget.project.starred!
                  ? GuamColorFamily.orangeCore
                  : GuamColorFamily.grayscaleGray5,
              textColor: GuamColorFamily.grayscaleGray5,
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Text(
          widget.project.description ?? "",
          style: TextStyle(
            height: 2,
            fontSize: 11,
            fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular,
          ),
        ),
      ),
    ]);
  }
}
