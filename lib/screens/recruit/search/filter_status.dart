import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guam_community_client/commons/custom_divider.dart';

import '../../../styles/colors.dart';

class FilterStatus extends StatelessWidget{
  final Map filter;
  final Function removeSkill;
  final Function removePosition;
  final Function removeDue;
  final Map<String, dynamic> position = {
    'SERVER': {'label': '서버'},
    'WEB': {'label': '웹'},
    'MOBILE': {'label': '모바일'},
    'DESIGNER': {'label': '디자이너'},
  };
  final Map<String, dynamic> due = {
    '1': {'label' : '1개월 이하'},
    '2': {'label' : '3개월 이하'},
    '3': {'label' : '6개월 이하'},
    '4': {'label' : '6개월 이상'},
  };
  final Map<String, dynamic> skill =
  {
    'Spring':{'label' : 'Spring'},
    'Django':{'label' : 'Django'},
    'TypeScript':{'label' : 'TypeScript'},
    'Flutter':{'label' : 'Flutter'},
    'Android':{'label' : 'Android'},
    'IOS':{'label' : 'IOS'},
    'React':{'label' : 'React'},
    'Vue.js':{'label' : 'Vue.js'},
    'Angular':{'label' : 'Angular'},
    'RN' : {'label' : 'React Native'},
    'Node.js':{'label' : 'Node.js'},
    'Java':{'label' : 'Java'},
  };

  FilterStatus({required this.filter, required this.removeSkill, required this.removePosition, required this.removeDue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDivider(color: GuamColorFamily.grayscaleGray7),
        Container(
          color: GuamColorFamily.grayscaleWhite,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if(filter.containsKey('skill')) Row(
                children: [
                  Container(
                    height: 28,
                    padding: EdgeInsets.only(left: 10, right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: GuamColorFamily.grayscaleGray6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          skill[filter['skill']]['label'],
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        ),
                        SizedBox(
                          width: 26,
                          child: IconButton(
                            iconSize: 15,
                            //highlightColor: Colors.transparent,
                            splashRadius: 15,
                            padding: EdgeInsets.all(0),
                            icon: SvgPicture.asset(
                              'assets/icons/cancel_filled_x_transparent.svg',
                              color: Colors.black,
                              width: 15,
                              height: 15,
                            ),
                            onPressed: () {
                              removeSkill();
                            },),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8,)
                ],
              ),
              if(filter.containsKey('position')) Row(
                children: [
                  Container(
                    height: 28,
                    padding: EdgeInsets.only(left: 10, right: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: GuamColorFamily.grayscaleGray6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          position[filter['position']]['label'],
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 26,
                          child: IconButton(
                            iconSize: 15,
                            //highlightColor: Colors.transparent,
                            splashRadius: 15,
                            padding: EdgeInsets.all(0),
                            icon: SvgPicture.asset(
                              'assets/icons/cancel_filled_x_transparent.svg',
                              color: Colors.black,
                              width: 15,
                              height: 15,
                            ),
                            onPressed: () {
                              removePosition();
                            },),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8,)
                ],
              ),
              if(filter.containsKey('due')) Container(
                height: 28,
                padding: EdgeInsets.only(left: 10, right: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: GuamColorFamily.grayscaleGray6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      due[filter['due']]['label'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 26,
                      child: IconButton(
                        iconSize: 15,
                        //highlightColor: Colors.transparent,
                        splashRadius: 15,
                        padding: EdgeInsets.all(0),
                        icon: SvgPicture.asset(
                          'assets/icons/cancel_filled_x_transparent.svg',
                          color: Colors.black,
                          width: 15,
                          height: 15,
                        ),
                        onPressed: () {
                          removeDue();
                        },),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        CustomDivider(color: GuamColorFamily.grayscaleGray7),
      ],
    );
  }

}