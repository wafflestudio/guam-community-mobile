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
    super.initState();
  }

  void setContent(){
    setState(() => widget.input['content'] = _contentTextFieldController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: TextField(
        keyboardType: TextInputType.multiline,
        controller: _contentTextFieldController,
        onChanged: (e) => setContent(),
        maxLines: 1,
        style: TextStyle(fontSize: 14),
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
