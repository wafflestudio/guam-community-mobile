import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../commons/custom_divider.dart';
import '../../../styles/colors.dart';
import '../../../styles/fonts.dart';

class FilterButton extends StatefulWidget {
  final Map filter;
  final Function setSkill;
  final Function setPosition;
  final Function setDue;
  final Function clearFilter;
  final Function requestFocus;
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
  final List<Map<String, dynamic>> skill = [
    {
      'Spring':{'label' : 'Spring'},
      'Django':{'label' : 'Django'},
      'TypeScript':{'label' : 'TypeScript'},
      'Flutter':{'label' : 'Flutter'},

    },
    {
      'Android':{'label' : 'Android'},
      'IOS':{'label' : 'IOS'},
      'React':{'label' : 'React'},
      'Vue.js':{'label' : 'Vue.js'},

    },
    {
      'Angular':{'label' : 'Angular'},
      'RN' : {'label' : 'React Native'},
      'Node.js':{'label' : 'Node.js'},
      'Java':{'label' : 'Java'},
    }
  ];
  // late final Map<String, dynamic> categories = {
  //   'skill': {'label':'기술 스택', 'items': skill, 'currItem':filter['skill'] ?? '', 'function': setSkill},
  //   'position': {'label':'잔여 포지션', 'items': position, 'currItem':filter['position'] ?? '', 'function': setPosition},
  //   'due': {'label':'프로젝트 기간', 'items': due, 'currItem':filter['due'] ?? '', 'function': setDue},
  // };

  FilterButton({
    required this.filter,
    required this.setSkill,
    required this.setPosition,
    required this.setDue,
    required this.clearFilter,
    required this.requestFocus,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  String? selectedPosition;
  String? selectedSkill;
  String? selectedDue;

  @override
  void initState(){
    super.initState();
    selectedSkill = widget.filter['skill'] ?? '';
    selectedPosition = widget.filter['position'] ?? '';
    selectedDue = widget.filter['due'] ?? '';
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: IconButton(
          icon: SvgPicture.asset(
              widget.filter.isEmpty
                  ? 'assets/icons/filter_default.svg'
                  : 'assets/icons/filter_activated.svg'
          ),
          onPressed: () {
            selectedSkill = widget.filter['skill'] ?? '';
            selectedPosition = widget.filter['position'] ?? '';
            selectedDue = widget.filter['due'] ?? '';
            showMaterialModalBottomSheet(
        context: context,
        useRootNavigator: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) => StatefulBuilder(
          builder: (context, StateSetter setState) {
            return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 24, top: 24, right: 18, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '필터링',
                            style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray2),
                          ),
                          TextButton(
                            onPressed: () {
                              widget.clearFilter();
                              Navigator.of(context).pop();},
                            child: Text(
                              '초기화',
                              style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(30, 26),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ],
                      ),
                      CustomDivider(color: GuamColorFamily.grayscaleGray7),
                      // map 이용해서 기술 스택, 잔여포지션, 프로젝트 기간 한 코드로 하려고 했으나
                      // bottom sheet 내에서는 map를 사용했을 때
                      // toggle buttons의 state가 적용이 잘 안 되는 이슈가 있어 일단은 보류했습니다.
                      // ...widget.categories.entries.map((category) => Column(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.symmetric(vertical: 20),
                      //       child: Text(
                      //         category.value['label'],
                      //         style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular),
                      //       ),
                      //     ),
                      //     ToggleButtons(
                      //       children: [...category.value['items'].entries.map((e) => Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Text(
                      //           e.value['label'],
                      //           style: TextStyle(
                      //             fontSize: 13,
                      //             color: e.key == category.value['currItem']
                      //                 ? GuamColorFamily.grayscaleWhite
                      //                 : GuamColorFamily.grayscaleGray3,
                      //           ),
                      //         ),
                      //       ),
                      //       ),
                      //       ],
                      //       isSelected: [...category.value['items'].keys.map((e) => e == category.value['currItem'])],
                      //       onPressed: (idx) {
                      //         final String pressedKey = category.value['items'].keys.toList()[idx];
                      //         category.value['function'](category.value['currItem'] == pressedKey ? null : pressedKey);
                      //         switch(category.key){
                      //           case 'skill': setState((){selectedSkill = (selectedSkill == pressedKey) ? null : pressedKey;}); break;
                      //           case 'position': setState((){selectedPosition = (selectedPosition == pressedKey) ? null : pressedKey;}); break;
                      //           case 'due': setState((){selectedDue = (selectedDue == pressedKey) ? null : pressedKey;}); break;
                      //         }
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '기술 스택',
                          style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...widget.skill.map((skill) => ToggleButtons(
                        fillColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        renderBorder: false,
                        children: [...skill.entries.map((e) => Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: e.key == selectedSkill
                                      ? GuamColorFamily.purpleCore
                                      : GuamColorFamily.grayscaleGray3,
                                )
                            ),
                            child: Text(
                              e.value['label'],
                              style: TextStyle(
                                fontSize: 12,
                                color: e.key == selectedSkill
                                    ? GuamColorFamily.purpleCore
                                    : GuamColorFamily.grayscaleGray3,
                              ),
                            ),
                          ),
                        ),
                        ),
                        ],
                        isSelected: [...skill.keys.map((e) => e == selectedSkill)],
                        onPressed: (idx) {
                          final String pressedKey = skill.keys.toList()[idx];
                          widget.setSkill(selectedSkill == pressedKey ? null : pressedKey);
                          setState((){
                            selectedSkill = (selectedSkill == pressedKey) ? null : pressedKey;
                          });
                        },
                      ),),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '잔여 포지션',
                          style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ToggleButtons(
                        fillColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        renderBorder: false,
                        children: [...widget.position.entries.map((e) => Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: e.key == selectedPosition
                                      ? GuamColorFamily.purpleCore
                                      : GuamColorFamily.grayscaleGray3,
                              )
                            ),
                            child: Text(
                              e.value['label'],
                              style: TextStyle(
                                fontSize: 12,
                                color: e.key == selectedPosition
                                    ? GuamColorFamily.purpleCore
                                    : GuamColorFamily.grayscaleGray3,
                              ),
                            ),
                          ),
                        ),
                        ),
                        ],
                        isSelected: [...widget.position.keys.map((e) => e == selectedPosition)],
                        onPressed: (idx) {
                          final String pressedKey = widget.position.keys.toList()[idx];
                          widget.setPosition(selectedPosition == pressedKey ? null : pressedKey);
                          setState((){
                            selectedPosition = (selectedPosition == pressedKey) ? null : pressedKey;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          '프로젝트 기간',
                          style: TextStyle(fontSize: 14, height: 1.6, fontFamily: GuamFontFamily.SpoqaHanSansNeoRegular, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ToggleButtons(
                        fillColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        renderBorder: false,
                        children: [...widget.due.entries.map((e) => Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: e.key == selectedDue
                                      ? GuamColorFamily.purpleCore
                                      : GuamColorFamily.grayscaleGray3,
                                )
                            ),
                            child: Text(
                              e.value['label'],
                              style: TextStyle(
                                fontSize: 12,
                                color: e.key == selectedDue
                                    ? GuamColorFamily.purpleCore
                                    : GuamColorFamily.grayscaleGray3,
                              ),
                            ),
                          ),
                        ),
                        ),
                        ],
                        isSelected: [...widget.due.keys.map((e) => e == selectedDue)],
                        onPressed: (idx) {
                          final String pressedKey = widget.due.keys.toList()[idx];
                          widget.setDue(selectedDue == pressedKey ? null : pressedKey);
                          setState((){
                            selectedDue = (selectedDue == pressedKey) ? null : pressedKey;
                          });
                        },
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 21),
                          child: TextButton(
                            onPressed: () {
                              widget.requestFocus();
                              Navigator.of(context).pop();
                              },
                            child: Text(
                              widget.filter.isEmpty ? '검색하기' : '검색하기(${widget.filter.length})',
                              style: TextStyle(fontSize: 16, color: GuamColorFamily.purpleCore,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(30, 26),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        ),
      );},
      ),
    );
  }
}