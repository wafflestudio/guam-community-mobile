import 'package:flutter/material.dart';
import 'package:guam_community_client/models/projects/project.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../helpers/svg_provider.dart';
import '../../../styles/colors.dart';

class ProjectDetailInfo extends StatelessWidget {
  final Project project;

  const ProjectDetailInfo(this.project);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _selectDue(String? due) {
      switch (due) {
        case 'ONE': return '1개월 미만';
        case 'THREE': return '3개월 미만';
        case 'SIX': return '6개월 미만';
        case 'MORE': return '6개월 이상';
        default: return '미정';
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Image(
                image: SvgProvider('assets/icons/calendar_outlined.svg'),
                width: 18,
                height: 18,
              ),
              Text(
                ' 진행 기간',
                style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text('${_selectDue(project.due)}', style: TextStyle(fontSize: 14)),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 15),
            child: Row(
              children: [
                Image(
                  image: SvgProvider('assets/icons/people_filled.svg'),
                  width: 17,
                  height: 17,
                ),
                Text(
                  ' 참여 현황 ',
                  style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray1),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _columnName('포지션'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: project.techStacks!.map((e) {
                      return _text(e.position!);
                    }).toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _columnName('기술 스택'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: project.techStacks!.map((e) {
                      return _text(e.name!);
                    }).toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _columnName('인원 현황'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: project.techStacks!.map((e) {
                      int headCount = 0;
                      int leftCount = 0;
                      switch (e.position) {
                        case 'SERVER':
                          headCount = project.serverHeadCount!;
                          leftCount = project.serverHeadLeft!;
                          break;
                        case 'WEB':
                          headCount = project.webHeadCount!;
                          leftCount = project.webHeadLeft!;
                          break;
                        case 'MOBILE':
                          headCount = project.mobileHeadCount!;
                          leftCount = project.mobileHeadLeft!;
                          break;
                        case 'DESIGNER':
                          headCount = project.designerHeadCount!;
                          leftCount = project.designerHeadLeft!;
                          break;
                        default:
                          break;
                      }
                      return _percentBar(
                        size: size,
                        currentCnt: headCount - leftCount,
                        totalCnt: headCount,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _text(String text) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray1),
    ),
  );
}

Widget _columnName(String colName) {
  return Text(
    colName,
    style: TextStyle(fontSize: 13, color: GuamColorFamily.grayscaleGray3),
  );
}

Widget _percentBar({required Size size, required int currentCnt, required int totalCnt}) {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(30),
        child: LinearPercentIndicator(
          lineHeight: 22,
          animation: true,
          animationDuration: 500,
          width: 61,
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          progressColor: GuamColorFamily.purpleCore,
          backgroundColor: GuamColorFamily.grayscaleGray5,
          percent: totalCnt == 0 ? 0 : currentCnt / totalCnt,
          center: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 8),
            child: Text(
              "$totalCnt",
              style: TextStyle(fontSize: 12, color: GuamColorFamily.grayscaleWhite),
            ),
          ),
        ),
      ),
    ),
  );
}
