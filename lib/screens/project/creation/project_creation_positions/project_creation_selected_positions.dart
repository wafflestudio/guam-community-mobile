import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreationSelectedPositions extends StatefulWidget {
  final Map input;

  ProjectCreationSelectedPositions(this.input);

  @override
  State<ProjectCreationSelectedPositions> createState() =>
      _ProjectCreationSelectedPositionsState();
}

class _ProjectCreationSelectedPositionsState
    extends State<ProjectCreationSelectedPositions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(color: GuamColorFamily.purpleDark1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if ((widget.input["SERVER"]["techStack"] == '') &
              (widget.input["WEB"]["techStack"] == '') &
              (widget.input["MOBILE"]["techStack"] == '') &
              (widget.input["DESIGNER"]["techStack"] == ''))
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                "기술 스택과 인원을 선택해주세요.",
                style: TextStyle(fontSize: 14, color: GuamColorFamily.purpleCore),
              ),
            ),
          if ((widget.input["SERVER"]["techStack"] != '') ||
              (widget.input["WEB"]["techStack"] != '') ||
              (widget.input["MOBILE"]["techStack"] != '') ||
              (widget.input["DESIGNER"]["techStack"] != ''))
            Wrap(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _selectedPositions(_position),
                      _selectedPositions(_techStack),
                      _selectedPositions(_headCount),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _selectedPositions(Widget element(String position)) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...['SERVER', 'WEB', 'MOBILE', 'DESIGNER'].map((e) => element(e))
      ],
    );
  }

  setPosition(String positionEng) {
    String positionKor = '';
    switch (positionEng) {
      case 'SERVER':
        positionKor = '서버';
        break;
      case 'WEB':
        positionKor = '웹';
        break;
      case 'MOBILE':
        positionKor = '모바일';
        break;
      case 'DESIGNER':
        positionKor = '디자이너';
        break;
    }
    return positionKor;
  }

  Widget _position(String position) {
    return (widget.input[position]["techStack"].toString() != '')
        ? Row(
            children: [
              IconButton(
                iconSize: 23,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: SvgPicture.asset(
                  'assets/icons/cancel_outlined.svg',
                  color: GuamColorFamily.redCore,
                ),
                onPressed: () => setState(() {
                  widget.input[position]["techStack"] = '';
                  widget.input[position]["headCount"] = 0;
                }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Text(
                  setPosition(position),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _techStack(String position) {
    return (widget.input[position]["techStack"].toString() != '')
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.input[position]["techStack"],
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          )
        : Container();
  }

  Widget _headCount(String position) {
    return (widget.input[position]["techStack"].toString() != '')
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              widget.input[position]["headCount"].toString(),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          )
        : Container();
  }
}
