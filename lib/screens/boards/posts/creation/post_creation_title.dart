import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostCreationTitle extends StatefulWidget {
  final Map input;

  PostCreationTitle(this.input);

  @override
  _PostCreationTitleState createState() => _PostCreationTitleState();
}

class _PostCreationTitleState extends State<PostCreationTitle> {
  final _titleTextFieldController = TextEditingController();

  @override
  void initState() {
    _titleTextFieldController.text = widget.input['title'];
    super.initState();
  }

  void setTitle(){
    setState(() {
      widget.input['title'] = _titleTextFieldController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      controller: _titleTextFieldController,
      onChanged: (e) => setTitle(),
      maxLines: 1,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        hintText: "제목을 입력해주세요.",
        hintStyle: TextStyle(fontSize: 18, color: GuamColorFamily.grayscaleGray5),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}
