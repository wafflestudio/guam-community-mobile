import 'package:flutter/material.dart';
import 'package:guam_community_client/styles/colors.dart';

class PostCreationContent extends StatefulWidget {
  final Map input;

  PostCreationContent(this.input);

  @override
  _PostCreationContentState createState() => _PostCreationContentState();
}

class _PostCreationContentState extends State<PostCreationContent> {
  final _contentTextFieldController = TextEditingController();

  @override
  void initState() {
    _contentTextFieldController.text = widget.input['content'];
    super.initState();
  }

  void setContent(){
    setState(() => widget.input['content'] = _contentTextFieldController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: TextField(
        keyboardType: TextInputType.multiline,
        controller: _contentTextFieldController,
        onChanged: (e) => setContent(),
        maxLines: null,
        style: TextStyle(fontSize: 14, height: 1.6, color: GuamColorFamily.grayscaleGray2),
        decoration: InputDecoration(
          hintText: "내용을 입력해주세요.",
          hintStyle: TextStyle(fontSize: 14, color: GuamColorFamily.grayscaleGray5),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 20),
        ),
      ),
    );
  }
}
