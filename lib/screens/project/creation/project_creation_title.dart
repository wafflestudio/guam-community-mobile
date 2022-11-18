import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreateTitle extends StatefulWidget {
  final Map input;
  final Function checkButtonEnable;

  ProjectCreateTitle({required this.input, required this.checkButtonEnable});

  @override
  _ProjectCreateTitleState createState() => _ProjectCreateTitleState();
}

class _ProjectCreateTitleState extends State<ProjectCreateTitle> {
  final _projectNameController = TextEditingController();

  @override
  void initState() {
    _projectNameController.text = widget.input["title"];
    super.initState();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GuamColorFamily.grayscaleWhite,
      padding: EdgeInsets.only(left: 15, top: 14, right: 15, bottom: 5),
      child: Container(
        padding: EdgeInsets.only(bottom: 12),
        height: 70,
        child: TextFormField(
          maxLength: 30,
          onChanged: (text) {
            setState(() => widget.input["title"] = text);
            widget.checkButtonEnable();
          },
          controller: _projectNameController,
          cursorColor: GuamColorFamily.purpleDark1,
          style: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray1),
          decoration: InputDecoration(
            filled: true,
            fillColor: GuamColorFamily.grayscaleWhite,
            hintText: "프로젝트 이름을 입력해주세요.",
            hintStyle: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray5),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: GuamColorFamily.grayscaleGray4),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: GuamColorFamily.grayscaleGray7),
            ),
          ),
        ),
      ),
    );
  }
}
