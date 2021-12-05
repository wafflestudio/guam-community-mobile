import 'package:flutter/material.dart';

class PostCreationContent extends StatefulWidget {
  final Map input;

  PostCreationContent(this.input);

  @override
  _PostCreationContentState createState() => _PostCreationContentState();
}

class _PostCreationContentState extends State<PostCreationContent> {
  String content;

  @override
  void initState() {
    super.initState();
  }

  void setBoardType(){
    setState(() {
      content = '하이~~~~~~~ 반가워요';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.input);
    return Container();
  }
}
