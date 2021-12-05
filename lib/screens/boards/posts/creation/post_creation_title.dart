import 'package:flutter/material.dart';

class PostCreationTitle extends StatefulWidget {
  final Map input;

  PostCreationTitle(this.input);

  @override
  _PostCreationTitleState createState() => _PostCreationTitleState();
}

class _PostCreationTitleState extends State<PostCreationTitle> {
  String title;

  @override
  void initState() {
    super.initState();
  }

  void setBoardType(){
    setState(() {
      title = '안녕하세요. 반가워요';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.input);
    return Container();
  }
}
