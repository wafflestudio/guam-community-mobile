import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class ProjectCreateDescription extends StatefulWidget {
  final Map input;
  final Function checkButtonEnable;

  ProjectCreateDescription({required this.input, required this.checkButtonEnable});

  @override
  _ProjectCreateDescriptionState createState() => _ProjectCreateDescriptionState();
}

class _ProjectCreateDescriptionState extends State<ProjectCreateDescription> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text = widget.input["description"];
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Container(
        color: GuamColorFamily.grayscaleWhite,
        padding: EdgeInsets.only(left: 15, top: 14, right: 15, bottom: 20),
        child: Container(
          height: 180,
          child: TextFormField(
            maxLength: 400,
            onChanged: (text) {
              setState(() => widget.input["description"] = text);
              widget.checkButtonEnable();
            },
            controller: _descriptionController,
            cursorColor: GuamColorFamily.purpleDark1,
            style: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray2),
            maxLines: 10,
            decoration: InputDecoration(
              filled: true,
              fillColor: GuamColorFamily.grayscaleWhite,
              hintText: "프로젝트를 소개해주세요. \nex) 목적, 하고 싶은 말, 진행 방식 등",
              hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
